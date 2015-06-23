# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  name                  :string
#  category              :string
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
#  description           :text
#

class Event < ActiveRecord::Base
  has_paper_trail

  has_many :event_admins
  has_many :users, through: :event_admins
  has_many :registrations
  has_many :teams

  validates :name, presence: true
  validates :category, presence: true
  validates :team_size, presence: true
  validates :team_size, numericality: { only_integer: true, :less_than_or_equal_to => 6, :greater_than_or_equal_to => 1 }

  extend Enumerize
  enumerize :category, in: ["CSE","ECE","Flagship","Non Tech","School","Workshop"]

  def to_s
    self.name
  end

  rails_admin do
    show do
      field :name
      field :category
      field :description do
        pretty_value do
          bindings[:object].description.html_safe
        end
      end
      field :users
      field :rules do
        pretty_value do
          bindings[:object].rules.html_safe
        end
      end
      field :judging do
        pretty_value do
          bindings[:object].judging.html_safe
        end
      end
      field :event_date_time
      field :team_size
      field :venue
      field :eligibilty
      field :registration_deadline
      field :prizes do
        pretty_value do
          bindings[:object].prizes.html_safe
        end
      end
      field :contact do
        pretty_value do
          bindings[:object].contact.html_safe
        end
      end
      field :photo
    end
    list do
      field :name
      field :category
      field :users
    end
    edit do
      field :name
      field :category
      field :description, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
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
