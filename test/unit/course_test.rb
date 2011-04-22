require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  
  test "course factory" do
    assert Factory(:course).valid?
  end
  
  test "can create valid course" do
    course = Course.new(:course=>"ACCY", :code=>"111")
    assert course.valid?
    assert course.save!
  end
  
  test "course needs course" do
    course = Course.new(:code=>"111")
    assert course.invalid?
  end
  
  test "course needs code" do
    course = Course.new(:course=>"ACCY")
    assert course.invalid?
  end
  
end
