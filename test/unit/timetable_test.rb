require 'test_helper'

class TimetableTest < ActiveSupport::TestCase
  # 
  # test "timetable can be blank" do
  #   assert Timetable.new.valid?
  # end
  # 
  # test "timetable can have an enrollment" do
  #   t = Timetable.create!
  #   assert_difference "t.enrollments.count" do
  #     t.enrollments << Factory(:enrollment, :timetable => t)
  #   end
  # end
  # 
  test "timetable can have course" do
    t = Factory(:timetable)
    course = Factory(:course)
    stream = Factory(:stream, :course => course)
    enrollment = Factory(:enrollment, :stream => stream, :timetable => t)
  
    assert_equal course, t.courses.first
  end
  
end
