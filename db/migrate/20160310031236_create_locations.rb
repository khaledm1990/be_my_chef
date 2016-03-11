class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.references :event, index: true, foreign_key: true
      t.string :block
      t.string :street
      t.string :city
      t.string :state
      t.integer :postal_code
      t.timestamps null: false
    end
  end

  def down
    drop_table :locations
  end
  
end
