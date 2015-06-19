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
# Indexes
#
#  index_registrations_on_event_id        (event_id)
#  index_registrations_on_participant_id  (participant_id)
#

class Registration < ActiveRecord::Base
  has_paper_trail

  belongs_to :participant
  belongs_to :event

  validates :participant, presence: true
  validates :event, presence: true

  def to_s
    self.participant.to_s + " - " + self.event.to_s
  end

  rails_admin do
    show do
      field :participant
      field :event
    end
    list do
      field :participant
      field :event
    end
    edit do
      field :participant
      field :event
    end
  end
end
