class Timetable < ActiveRecord::Base
  
  has_many :enrollments
  has_many :streams, :through => :enrollments
  
  def courses
    Course.joins(:streams => :timetables).where("timetable_id = #{self.id}").group('timetables.id')
  end
  
  def events
    Event.joins(:stream => :timetables).where("timetable_id = #{self.id}")
  end
  
end
