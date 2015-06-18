class Team < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :event
  has_many :participant_teams
end
