class Event < ActiveRecord::Base
  has_paper_trail
  
  has_many :event_admins
  has_many :registrations
  has_many :teams
end
