# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  college    :string
#  created_at :datetime
#  updated_at :datetime
#  uid        :string
#  provider   :string
#

class Participant < ActiveRecord::Base
  has_paper_trail

  has_many :participant_teams
  has_many :registrations

  has_many :events, through: :registrations

  validates :name, presence: true
  # validates :email, presence: true
  # validates :phone, presence: true
  # validates :college, presence: true

  def to_s
    self.name
  end


  def self.from_omniauth(auth)
    where("provider = ? AND uid = ? OR email = ?", auth.provider, auth.uid, auth.info.email).first_or_create! do |participant|
      participant.email = auth.info.email
      participant.name = auth.info.name
      participant.uid = auth.uid
      participant.provider = auth.provider
    end
  end

  rails_admin do
    show do
      field :name
      field :email
      field :phone
      field :college
      field :events
      field :participant_teams
    end
    list do
      field :name
      field :email
      field :phone
      field :college
    end
    edit do
      field :name
      field :email
      field :phone
      field :college
      field :events
      field :participant_teams
    end
  end
end
