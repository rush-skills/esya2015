class EventAdmin < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :event
  belongs_to :user
end
