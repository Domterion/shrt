require "mongo"

require "./url"
require "./config"

class Shrt::Database
  CLIENT     = Mongo::Client.new MONGO
  DB         = CLIENT["shrt"]
  COLLECTION = DB["shrt"]

  @@urls = {} of String => Shrt::Url

  def initialize
    begin
      COLLECTION.find({} of String => String).each do |doc|
        url = Shrt::Url.from_json({"slug": doc["slug"].as(String), "url": doc["url"].as(String), "created": doc["created"].as(Int64)}.to_json)
        add_url(url, false)
      end
    rescue ex
      puts "[DATABASE] Error when adding at in it : #{ex}"
    end
  end

  def add_url(url : Shrt::Url, db : Bool = true)
    if db
      begin
        COLLECTION.insert({"slug" => url.slug, "url" => url.url, "created" => url.created})
      rescue ex
        puts "[MONGO] Error when inserting url #{url} : #{ex}"
      end
    end

    @@urls[url.slug] = url

    puts "Added #{url.slug}"
  end

  def delete_url(slug : String)
    begin
      COLLECTION.remove({"slug" => slug})
    rescue ex
      puts "[MONGO] Error when deleting url #{slug} : #{ex}"
    end
    @@urls.delete(slug)

    puts "Deleted #{slug}"
  end

  def get_url(slug : String)
    @@urls[slug]?
  end
end
