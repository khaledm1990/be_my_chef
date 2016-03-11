class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :name
      t.date :date
      t.time :starting_time
      t.time :ending_time
      t.string :pax
      t.string :variety
      t.string :description
      t.timestamps null: false

    end
  end
end
