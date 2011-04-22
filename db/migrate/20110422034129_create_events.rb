class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :stream_id
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
