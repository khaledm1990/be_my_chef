class AddClosedToEvents < ActiveRecord::Migration
  def up
    add_column :events, :closed, :boolean, default: false
  end

  def down
    add_column :events, :closed
  end
end
