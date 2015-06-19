# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  name                  :string
#  type                  :string
#  rules                 :text
#  judging               :text
#  event_date_time       :datetime
#  team_size             :integer
#  venue                 :string
#  eligibilty            :string
#  registration_deadline :datetime
#  prizes                :text
#  contact               :text
#  photo                 :string
#  created_at            :datetime
#  updated_at            :datetime
#

class Event < ActiveRecord::Base
  has_paper_trail

  has_many :event_admins
  has_many :users, through: :event_admins
  has_many :registrations
  has_many :teams

  validates :name, presence: true
  validates :type, presence: true
  validates :team_size, presence: true
  validates :team_size, numericality: { only_integer: true, :less_than_or_equal_to => 6, :greater_than_or_equal_to => 1 }

  extend Enumerize
  enumerize :type, in: ["CSE","ECE","Flagship","Non Tech","School","Workshop"]

  def to_s
    self.name
  end

  rails_admin do
    show do
      field :name
      field :type
      field :users
      field :rules
      field :judging
      field :event_date_time
      field :team_size
      field :venue
      field :eligibilty
      field :registration_deadline
      field :prizes
      field :contact
      field :photo
    end
    list do
      field :name
      field :type
      field :users
    end
    edit do
      field :name
      field :type
      field :rules, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
      field :judging, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
      field :event_date_time
      field :team_size
      field :venue
      field :eligibilty
      field :registration_deadline
      field :prizes, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
      field :contact, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
      field :photo
      field :users
    end
  end

end
