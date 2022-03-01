class CreateTagViews < ActiveRecord::Migration[6.1]
  def change
    create_view :tag_views
  end
end
