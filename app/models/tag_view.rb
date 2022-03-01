class TagView < ApplicationRecord
  self.primary_key = :id

  scope :query_by_name, ->(name)   { where("name ILIKE ?", "%#{name}%") }

  def readonly?
    true
  end
  
end
