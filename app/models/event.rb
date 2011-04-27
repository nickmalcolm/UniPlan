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
  
  private
  
    def set_string_times
      self.starts_at_str  = "#{self.starts_at.hour}:#{self.starts_at.min}"
      self.ends_at_str    = "#{self.ends_at.hour}:#{self.ends_at.min}"
      self.day_str = "#{self.starts_at.strftime('%A')}"
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
