class CreateStreams < ActiveRecord::Migration
  def self.up
    create_table :streams do |t|
      t.integer :crn
      t.integer :course_id
      t.timestamps
    end
  end

  def self.down
    drop_table :streams
  end
end
