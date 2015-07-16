# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  tid        :string
#  team_name  :string
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_teams_on_event_id  (event_id)
#

class Team < ActiveRecord::Base
  has_paper_trail

  belongs_to :event
  has_many :participant_teams, dependent: :destroy
  has_many :participants, through: :participant_teams

  validates :team_name, presence: true
  validates :event, presence: true

  before_create :generate_tid

  def to_s
    self.team_name.to_s + " - " + self.event.to_s
  end

  def generate_tid
    random = SecureRandom.hex 2
    if Team.find_by_tid(random)
      generate_tid
    else
      self.tid ||= random
    end
    random
  end

  rails_admin do
    show do
      field :team_name
      field :event
      field :tid
      field :participants
    end
    list do
      field :team_name
      field :event
    end
    edit do
      field :team_name
      field :event
      field :tid
      field :participants
    end
  end
end
