class AddRoomToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :room, :string
  end

  def self.down
    remove_column :events, :room
  end
end
