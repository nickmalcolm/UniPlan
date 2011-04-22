class Event < ActiveRecord::Base
  
  belongs_to :stream
  
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  
end

class Lecutre < Event
end

class Workshop < Event
end

class Studio < Event
end

class Lab < Event
end
