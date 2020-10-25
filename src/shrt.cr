require "kemal"
require "json"
require "nanoid"

require "./shrt/utils"
require "./shrt/url"
require "./shrt/database"

module Shrt
  VERSION  = "0.1.0"
  DATABASE = Shrt::Database.new

  get "/" do |env|
    render "src/views/index.ecr", layout: "src/views/layout.ecr"
  end

  get "/:slug" do |env|
    env.response.content_type = "application/json"

    slug = env.params.url["slug"].to_s

    found = DATABASE.get_url slug

    if found
      env.redirect found.url
    else
      {"msg": "#{slug} is not a registered slug."}.to_json
    end
  end

  post "/url" do |env|
    env.response.content_type = "application/json"

    slug = env.params.json["slug"]? ? env.params.json["slug"].as(String) : Nanoid.generate 7
    halt env, 400, ({"msg": "Invalid slug provided."}.to_json) if (Shrt::Utils.validate_slug slug).nil?

    halt env, 409, ({"msg": "Slug already registered."}.to_json) if !(DATABASE.get_url slug).nil?

    url = env.params.json["url"]? ? env.params.json["url"].as(String) : halt env, 400, ({"msg": "No url provided."}.to_json)
    halt env, 400, ({"msg": "Invalid url provided."}.to_json) if (Shrt::Utils.validate_url url).nil?

    DATABASE.add_url Shrt::Url.from_json({"slug": slug, "url": url, "created": Time.utc.to_unix}.to_json)

    {"msg": "#{slug} added.", "slug": slug, "url": url}.to_json
  end

  error 500 do |env|
    env.response.content_type = "application/json"
    {"msg": "Server error, please try again."}.to_json
  end

  Kemal.run PORT
end
