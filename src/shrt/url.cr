class Shrt::Url
  include JSON::Serializable

  getter slug : String
  getter url : String
  getter created : Int64
end
