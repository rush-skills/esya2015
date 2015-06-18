# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  tid        :string(255)
#  team_name  :string(255)
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
