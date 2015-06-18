# == Schema Information
#
# Table name: event_admins
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class EventAdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
