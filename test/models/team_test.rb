# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  tid        :string
#  team_name  :string
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_teams_on_event_id  (event_id)
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
