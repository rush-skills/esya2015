# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  title      :string
#  message    :text
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notifications_on_event_id  (event_id)
#

class Notification < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :event
  has_and_belongs_to_many :participants

  validates :title, presence: true
  validates :message, presence: true

  after_create do |notification|
    require 'gcm'

    tokens = []
    if notification.event
      if notification.event.team_event?
        notification.event.participants.each do |p|
          tokens << p.gcm_token if p.gcm_token
        end
      else
        notification.event.registrations.each do |r|
          if r.participant
            tokens << r.participant.gcm_token if r.participant.gcm_token
          end
        end
      end
    end

    notification.participants.each do |p|
      tokens << p.gcm_token if p.gcm_token
    end

    gcm = GCM.new(ENV["GCM_KEY"])
    options = {data: {title: notification.title, body: notification.message}}
    response = gcm.send(tokens,options)
    Rails.logger.warn ("GCM Sent, Response: " + response.to_s)
  end


  rails_admin do
    show do
      field :title
      field :message
      field :event
      field :participants
    end
    list do
      field :title
      field :event
    end
    edit do
      field :event
      field :title
      field :message
      field :participants
    end
  end
end
