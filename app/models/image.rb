class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  has_many :image_tags, dependent: :destroy
  has_many :tags, through: :image_tags

  validates :name, :file, presence: true

  before_save :set_file_size, if: -> { self.size.nil? }

  scope :filter_by_tag, ->(tag_id) { joins(:image_tags).where(image_tags: { tag_id: tag_id }) }
  scope :query_by_name, ->(name)   { where("name ILIKE ?", "%#{name}%") }

  private
    def set_file_size
      self.size = self.file.size
    end
end
