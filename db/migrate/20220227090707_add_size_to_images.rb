class AddSizeToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :size, :bigint
  end
end
