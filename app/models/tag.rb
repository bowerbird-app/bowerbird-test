class Tag < ApplicationRecord
  belongs_to :user

  has_many :image_tags
  has_many :images, through: :image_tags

  validates :name, presence: true, uniqueness: { scope: :user_id }

  scope :query_by_name, ->(name)   { where("name ILIKE ?", "%#{name}%") }
end
