class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.boolean :gender
      t.string :address
      t.integer :phone_number
      t.integer :role, default: 0, null: false
      t.timestamps
    end
  end
end
