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

class Event < ActiveRecord::Base
  has_paper_trail
  
  has_many :event_admins
  has_many :registrations
  has_many :teams
end
