class Stream < ActiveRecord::Base
  belongs_to :course
  has_many :events
  
  validates :course, :presence => true
  validates :crn, :presence => true, :uniqueness => true
end
