class Stream < ActiveRecord::Base
  belongs_to :course
  has_many :events
  
  validates :crn, :presence => true, :uniqueness => true
end
