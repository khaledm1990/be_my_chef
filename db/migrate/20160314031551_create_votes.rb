class CreateVotes < ActiveRecord::Migration
  
  def up
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :voted_id
      t.integer :cast
      t.timestamps null: false
    end

    add_index :votes, :voter_id
    add_index :votes, :voted_id
    add_index :votes, [:voter_id, :voted_id], unique: true

  end

  def down
  	drop_table :votes
  end

end
