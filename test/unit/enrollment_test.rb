require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  
  test "Enrollments need stream and timetable" do
    assert Enrollment.new.invalid?
  end
  
  test "Enrollments need stream" do
    assert Enrollment.new(:timetable => Factory(:timetable)).invalid?
  end
  
  test "Enrollments need timetable" do
    assert Enrollment.new(:stream => Factory(:stream)).invalid?
  end
  
  test "Enrollment valid with stream and timetable" do
    assert Enrollment.new(:stream => Factory(:stream), :timetable => Factory(:timetable)).valid?
  end
  
  test "Enrollment has course through stream" do
    course = Factory(:course)
    stream = Factory(:stream, :course => course)
    
    e = Enrollment.create!(:stream => stream, :timetable => Factory(:timetable))
    
    assert_equal course, e.course
  end
  
end
