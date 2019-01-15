class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :author, foreign_key: true
      t.references :category, foreign_key: true
      t.references :publisher, foreign_key: true
      t.string :name
      t.text :description
      t.integer :num_of_pages
      t.text :image
      t.integer :amount
      t.timestamps
    end
  end
end
