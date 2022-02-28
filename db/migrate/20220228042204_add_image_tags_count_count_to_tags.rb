class AddImageTagsCountCountToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :image_tags_count, :integer
  end
end
