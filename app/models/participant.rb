class Participant < ActiveRecord::Base
  has_paper_trail
  
  has_many :participant_teams
  has_many :registrations
end
