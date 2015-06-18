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

require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
