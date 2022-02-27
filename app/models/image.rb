class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  has_many :image_tags
  has_many :tags, through: :image_tags

  after_commit :tag_image, on: :create

  private
    def tag_image
      client = ClarifaiClient.new
      if client.call(file.url)
        self.tags.create(client.tags)
      end
    end
end
