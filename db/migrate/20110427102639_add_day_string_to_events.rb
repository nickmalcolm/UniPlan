class AddDayStringToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :day_str, :string
  end

  def self.down
    remove_column :events, :day_str
  end
end
