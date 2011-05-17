class Enrollment < ActiveRecord::Base
  
  belongs_to :stream
  has_many :events, :through => :stream
  belongs_to :timetable
  
  validates :stream_id, :presence => true
  validates :timetable_id, :presence => true
  
end
