class AddImageIdToType < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :image_id, :string
  end
end
