class Enrollment < ActiveRecord::Base
  
  belongs_to :stream
  belongs_to :timetable
  has_one :course, :through => :stream
  
  validates :stream_id, :presence => true
  validates :timetable_id, :presence => true
end
