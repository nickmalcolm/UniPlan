require 'test_helper'

class StreamTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert Factory(:stream).valid?
  end
  
  test "can create valid stream" do
    stream = Stream.new(:crn => 12345, :course => Factory(:course))
    assert stream.valid?
    assert stream.save!
  end
  
  test "stream needs course" do
    stream = Stream.new(:crn => 12345)
    
    assert stream.invalid?
  end
  
  test "stream needs crn" do
    stream = Stream.new(:course => Factory(:course))
    
    assert stream.invalid?
  end
    
  
end
