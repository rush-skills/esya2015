# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  college    :string
#  created_at :datetime
#  updated_at :datetime
#  uid        :string
#  provider   :string
#

require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
