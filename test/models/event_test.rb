# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  name                  :string
#  rules                 :text
#  judging               :text
#  event_date_time       :datetime
#  team_size             :integer
#  venue                 :string
#  eligibilty            :string
#  registration_deadline :datetime
#  prizes                :text
#  contact               :text
#  photo                 :string
#  created_at            :datetime
#  updated_at            :datetime
#  description           :text
#  short_code            :string
#
# Indexes
#
#  index_events_on_short_code  (short_code) UNIQUE
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
