class AddFileSizeToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :file_size, :integer
  end
end
