class Shrt::Utils
  SLUG_REGEX = /^[\w\-]+$/
  URL_REGEX  = /^https?:\/\/?([\da-z\.-]+\.[a-z\.]{2,6}|[\d\.]+)([\/:?=&#]{1}[\da-z\.-]+)*[\/\?]?$/

  def self.validate_slug(slug : String)
    SLUG_REGEX.match(slug)
  end

  def self.validate_url(url : String)
    URL_REGEX.match(url)
  end
end
