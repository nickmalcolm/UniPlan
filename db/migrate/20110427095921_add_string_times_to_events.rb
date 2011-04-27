class AddStringTimesToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :starts_at_str, :string
    add_column :events, :ends_at_str, :string
  end

  def self.down
    remove_column :events, :ends_at_str
    remove_column :events, :starts_at_str
  end
end
