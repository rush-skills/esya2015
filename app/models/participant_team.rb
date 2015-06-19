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
# Indexes
#
#  index_participant_teams_on_participant_id  (participant_id)
#  index_participant_teams_on_team_id         (team_id)
#

class ParticipantTeam < ActiveRecord::Base
  has_paper_trail

  belongs_to :team
  belongs_to :participant

  def to_s
    self.team.to_s + " - " + self.participant.to_s
  end

  rails_admin do
    show do
      field :team
      field :participant
    end
    list do
      field :team
      field :participant
    end
    edit do
      field :team
      field :participant
    end
  end
end
