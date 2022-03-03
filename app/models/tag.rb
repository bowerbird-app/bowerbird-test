class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :image_tags
  has_many :images, through: :image_tags
end
