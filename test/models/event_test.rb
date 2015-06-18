# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  type                  :string(255)
#  rules                 :text
#  judging               :text
#  event_date_time       :datetime
#  team_size             :integer
#  venue                 :string(255)
#  eligibilty            :string(255)
#  registration_deadline :datetime
#  prizes                :text
#  contact               :text
#  photo                 :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
