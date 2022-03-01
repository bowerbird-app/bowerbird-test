class TagImageJob < ApplicationJob
  queue_as :default

  def perform(image_id)
    image = Image.find(image_id)
    client = ClarifaiClient.new
    client.tags.each do |tag|
      internal_tag = Tag.find_or_create_by(name: tag[:name].titleize)
      image.image_tags.create(tag: internal_tag, probability: tag[:probability])
    end if client.call(image.file.url)
  end
end
