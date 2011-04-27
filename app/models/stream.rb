class Stream < ActiveRecord::Base
  belongs_to :course
  has_many :events, :dependent => :destroy
  
  has_many :enrollments
  has_many :timetables, :through => :enrollments
  
  validates :course, :presence => true
  validates :crn, :presence => true, :uniqueness => true
end
