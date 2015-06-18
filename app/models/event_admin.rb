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

class EventAdmin < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :event
  belongs_to :user
end
