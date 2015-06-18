# == Schema Information
#
# Table name: participant_teams
#
#  id             :integer          not null, primary key
#  team_id        :integer
#  participant_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ParticipantTeam < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :team
  belongs_to :participant
end
