class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.references :user, foreign_key: true
      t.string :note
      t.datetime :date_borrow, default: Time.current.in_time_zone("Hanoi")
      t.datetime :end_date_borrow, default: Time.current.in_time_zone("Hanoi")+7.days
      t.integer :status, default: 0, null:false
      t.timestamps
    end
  end
end
