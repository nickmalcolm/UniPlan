class Timetable < ActiveRecord::Base
  
  has_many :enrollments
  has_many :events, :through => :enrollments
  has_many :streams, :through => :enrollments
  
  def events
    Event.find(:all, :conditions => ["stream_id IN (?)", self.streams.collect {|s| s.id }])
  end
  
end
