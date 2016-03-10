class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.date :date
      t.integer :guest_number
      t.timestamps null: false
    end
  end
end
