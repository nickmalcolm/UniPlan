class Event < ActiveRecord::Base
  
  belongs_to :stream
  
  validates :stream, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  
  before_save :set_string_times
  
  scope :which_start_at, lambda { |hour|
      where("events.starts_at_str = ?", "#{hour}:0")
  }
  
  scope :on_day, lambda { |day| 
    where("events.day_str = ?", day)}
  
  
  def matches?(day, hour)
    false
  end
  
  def name
    "#{stream.course.name} in #{room}"
  end
  
  def as_json(options={})
    hash = Hash.new
    hash[:day] = starts_at.strftime('%A')
    hash[:starts_hour] = starts_at.strftime('%H')
    hash[:starts_min] =  starts_at.strftime('%M')
    hash[:duration] = 50
    hash[:name] = name
    hash[:room] = room
    return hash
  end
  
  private
  
    def set_string_times
      #starts_at_str  = "#{self.starts_at.strftime('%H:%M')}"
      #ends_at_str    = "#{self.ends_at.strftime('%H:%M')}"
      #day_str = "#{self.starts_at.strftime('%A')}"
    end
  
end

class Lecutre < Event
end

class Workshop < Event
end

class Studio < Event
end

class Lab < Event
end
