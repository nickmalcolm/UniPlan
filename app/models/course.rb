class Course < ActiveRecord::Base
  
  has_many :streams, :dependent => :destroy
  
  validates :course, :presence => true
  validates :code, :presence => true
  
end
