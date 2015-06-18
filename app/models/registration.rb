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

class Registration < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :participant
  belongs_to :event
end
