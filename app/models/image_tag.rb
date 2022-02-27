class ImageTag < ApplicationRecord
  validates :tag_id, uniqueness: { scope: :image_id }
  validates :probability, presence: true

  belongs_to :image
  belongs_to :tag
end
