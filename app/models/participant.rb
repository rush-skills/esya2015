class Participant < ActiveRecord::Base
  has_many :participant_teams
  has_many :registrations
end
