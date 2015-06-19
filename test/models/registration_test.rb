# == Schema Information
#
# Table name: registrations
#
#  id             :integer          not null, primary key
#  participant_id :integer
#  event_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_registrations_on_event_id        (event_id)
#  index_registrations_on_participant_id  (participant_id)
#

require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
