class AddVarietyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :variety, :string
  end
end
