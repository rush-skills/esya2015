# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  college    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Participant < ActiveRecord::Base
  has_paper_trail
  
  has_many :participant_teams
  has_many :registrations
end
