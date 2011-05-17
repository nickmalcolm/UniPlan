class Course < ActiveRecord::Base
  
  has_many :streams, :dependent => :destroy
  has_many :events, :through => :streams
  
  validates :course, :presence => true
  validates :code, :presence => true
  
  def to_param
    "#{id}-#{name}"
  end
  
  def name
    ""+course+code
  end
  
end
