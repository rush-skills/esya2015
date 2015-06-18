class Registration < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :participant
  belongs_to :event
end
