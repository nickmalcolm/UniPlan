class Course < ActiveRecord::Base
  
  has_many :streams
  
  validates :course, :presence => true
  validates :code, :presence => true
  
end
