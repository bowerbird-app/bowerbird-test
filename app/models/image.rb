class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  validates :name, :file, presence: true

  belongs_to :user
  has_many :image_tags
  has_many :tags, through: :image_tags

  # Searches by tag name
  scope :by_tag_name, -> (tag_name) do
    return self if tag_name.nil? || tag_name.casecmp?("all")
    self.joins(:tags).where("tags.name ILIKE ?", tag_name)
  end

  # Searches by name or description
  scope :query, -> (query) do
    return if !query.present?
    self.where("images.name ILIKE ?", "%#{query}%")
        .or(self.where("images.description ILIKE ?", "%#{query}%"))
  end

  # Group tags that a group of image has.
  # This is for displaying tags along with how
  # many images does a tag has.
  #
  # Add `with_total: true` to add in total count.
  def self.tags_with_count(with_total: false)
    tags_list = self.joins(:tags)
                    .pluck('tags.name')
                    .group_by(&:itself)
                    .map { |k, v| [ k, v.count ] }
                    .to_h

    with_total ? tags_list["All"] = self.count : nil

    tags_list
  end

  # Get all tag names in an array
  def tag_names
    self.tags.pluck(:name)
  end
end
