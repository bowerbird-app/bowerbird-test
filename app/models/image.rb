class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :user

  has_many :image_tags, dependent: :destroy
  has_many :tags, through: :image_tags
  
  validates :name, :file, presence: true
  
  after_commit :tag_image, on: :create

  before_save :set_file_size, if: -> { self.size.nil? }

  scope :filter_by_tag, ->(tag_id) { joins(:image_tags).where(image_tags: { tag_id: tag_id }) }
  scope :query_by_name, ->(name)   { where("name ILIKE ?", "%#{name}%") }

  private
    def set_file_size
      self.size = self.file.size
    end

    def tag_image
      TagImageJob.perform_later(self.id)
      # client = ClarifaiClient.new
      # client.tags.each do |tag|
      #   internal_tag = Tag.find_or_create_by(name: tag[:name].titleize)
      #   self.image_tags.create(tag: internal_tag, probability: tag[:probability])
      # end if client.call(file.url)
    end
end
