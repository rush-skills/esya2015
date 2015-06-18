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

class Team < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :event
  has_many :participant_teams
end
