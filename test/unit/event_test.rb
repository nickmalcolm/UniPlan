require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  test "event factory" do
    assert Factory(:event).valid?
  end
  
  test "can create valid event" do
    event = Event.new(:stream => Factory(:stream), :starts_at => 1.hour.ago, :ends_at => 1.minute.ago, :room => "MY102")
    assert event.valid?
    assert event.save!
  end
  
  test "event needs stream" do
    event = Event.new(:starts_at => 1.hour.ago, :ends_at => 1.minute.ago, :room => "MY102")
    
    assert event.invalid?
  end
  
  test "event needs start date" do
    event = Event.new(:stream => Factory(:stream), :ends_at => 1.minute.ago, :room => "MY102")
    
    assert event.invalid?
  end
  
  test "event needs end date" do
    event = Event.new(:stream => Factory(:stream), :starts_at => 1.hour.ago, :room => "MY102")
    
    assert event.invalid?
  end
  
  test "event needs a room" do
    event = Event.new(:stream => Factory(:stream), :starts_at => 1.hour.ago, :ends_at => 1.minute.ago)
    
    assert event.invalid?
  end
  
end
