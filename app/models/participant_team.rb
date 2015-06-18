class ParticipantTeam < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :team
  belongs_to :participant
end
