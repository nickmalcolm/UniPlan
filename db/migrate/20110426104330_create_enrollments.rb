class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.belongs_to :stream
      t.belongs_to :timetable

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollments
  end
end
