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

  mount_uploader :photo, PhotoUploader
  attr_accessor :photo_cache, :remove_photo
  extend Enumerize
  enumerize :category, in: ["CSE","ECE","Flagship","Non Tech","School","Workshop"]

  def to_s
    self.name
  end

  def info
    string = '<p>Event Name: '+self.name.to_s+'</p>'
    string +='<p>Category: '+self.category.to_s+'</p>'
    string +='<p>Team size limit: '+self.team_size.to_s+'</p>'
    string +='<p>Eligibility: '+self.eligibilty.to_s+'</p>' if self.eligibilty
    string += '<p>Time: '+self.event_date_time.strftime("%D %r")+'</p>' if self.event_date_time
    string += '<p>Registration Deadline: '+self.registration_deadline.strftime("%D %r")+'</p>' if self.registration_deadline
    string += '<p>Venue: '+self.venue.to_s+'</p>' if self.venue
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
      field :team_size
      field :photo
      field :event_date_time
      field :venue
      field :eligibilty
      field :registration_deadline
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
      field :users
    end
  end

end
