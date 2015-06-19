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
# Indexes
#
#  index_event_admins_on_event_id  (event_id)
#  index_event_admins_on_user_id   (user_id)
#

class EventAdmin < ActiveRecord::Base
  has_paper_trail

  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true

  def to_s
    self.event.to_s + " - " + self.user.to_s
  end

  rails_admin do
    show do
      field :event
      field :user
    end
    list do
      field :event
      field :user
    end
    edit do
      field :event
      field :user
    end
  end
end
