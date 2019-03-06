# Class incapsultes interacting with Flickr API
require 'flickraw'

class FlickrApi
  def initialize(args = {})
    FlickRaw.api_key       = Rails.application.credentials.flickr[:key]
    FlickRaw.shared_secret = Rails.application.credentials.flickr[:secret]
    @flickr = FlickRaw::Flickr.new
    @default_args = { tag_mode: "all", media: "photos", per_page: 10 }
    @default_args.merge(args)
  end

  def search(args)
    @flickr.photos.search(@default_args.merge(args))
  end

  def self.url(image)
    FlickRaw.url(image)
  end
end
