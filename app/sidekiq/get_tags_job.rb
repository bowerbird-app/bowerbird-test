class GetTagsJob
  include Sidekiq::Job

  def perform(id)
    image = Image.find_by(id: id)

    return if image.nil?

    response = Clarifai::GeneralImageRecognition.get_output(image.file.url)

    output = response.dig(:outputs)&.first

    return if output.nil?

    tags_data = output.dig(:data, :concepts)

    tags_data.each do |data|
      tag = Tag.find_or_create_by(name: data[:name].titleize)
      image.image_tags.create(tag: tag, probability: data[:value])
    end
  end
end
