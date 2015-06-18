class Team < ActiveRecord::Base
  belongs_to :event
  has_many :participant_teams
end
