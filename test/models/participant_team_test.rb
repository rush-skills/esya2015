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

require 'test_helper'

class ParticipantTeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
