class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image_id
      t.string :body
      t.integer :price
      t.integer :quantity
      t.text :material
      t.text :make
      t.integer :genre_id
      t.integer :type_id
      t.timestamps
    end
  end
end
