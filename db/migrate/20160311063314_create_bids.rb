class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.string :price
      t.boolean :deal, default: false
      t.timestamps null: false
    end
  end
end
