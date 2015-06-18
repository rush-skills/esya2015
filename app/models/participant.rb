class Participant < ActiveRecord::Base
  has_many :participant_teams
end
