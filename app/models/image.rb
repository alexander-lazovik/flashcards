class Image
  attr_reader :id, :title, :url

  def initialize(image)
    @id = image.id
    @title = image.title
    @url = FlickrApi.url(image)
  end

  def self.search(tags)
    args = { tags: tags }
    flickr = FlickrApi.new
    images = flickr.search(args)
    images.map { |image| Image.new(image) }
  end
end
