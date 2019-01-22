class CreateBorrowDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :borrow_details do |t|
      t.references :borrow, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :number
      t.timestamps
    end
  end
end
