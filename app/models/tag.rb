class Tag < ApplicationRecord
  has_many :image_tags
  has_many :images, through: :image_tags

  validates :name, presence: true, uniqueness: true

  scope :query_by_name, ->(name)   { where("name ILIKE ?", "%#{name}%") }
end
