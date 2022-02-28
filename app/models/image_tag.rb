class ImageTag < ApplicationRecord
  # An image should not have duplicated tags
  validates :tag_id, uniqueness: { scope: :image_id }
  validates :probability, presence: true

  belongs_to :image
  belongs_to :tag, counter_cache: true
end
