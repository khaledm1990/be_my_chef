class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :date, :date
    add_column :events, :starting_time, :time
    add_column :events, :ending_time, :time
    add_column :events, :pax, :string
  end
end
