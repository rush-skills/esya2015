# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  name                  :string
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
#  short_code            :string
#
# Indexes
#
#  index_events_on_short_code  (short_code) UNIQUE
#

class Event < ActiveRecord::Base
  has_paper_trail

  has_many :event_admins
  has_many :users, through: :event_admins
  has_many :registrations
  has_many :teams, dependent: :destroy
  has_many :participants, through: :teams
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :team_size, presence: true
  validates :team_size, numericality: { only_integer: true, :less_than_or_equal_to => 6, :greater_than_or_equal_to => 1 }

  mount_uploader :photo, PhotoUploader
  attr_accessor :photo_cache, :remove_photo
  extend Enumerize

  before_update :generate_short_code

  def to_s
    self.name
  end

  def team_event?
    self.team_size > 1
  end

  def registered?(participant)
    Registration.where(participant: participant, event: self).first.present? or self.participants.where(id: participant.id).first.present?
  end

  def get_team participant
    self.participants.where(id: participant.id).get_team(self)
    self.save!
  end

  def generate_short_code
    self.short_code = self.name.squish.downcase.tr(" ","_").tr(".","_")
  end

  def is_admin user
    self.event_admins.where(user: user).first.present?
  end

  def info
    string = ""
    string += '<div class="image-center"><img height="250px" src="'+self.photo.url+'"></div>' if self.photo.present?
    # string += '<p>Event Name: '+self.name.to_s+'</p>'
    # string +='<p>Category: '+self.category.to_s+'</p>'
    string +='<h2 align="center"><b>Team size limit:</b> '+self.team_size.to_s+' people'
    string +='&nbsp&nbsp|&nbsp&nbsp<b>Eligibility:</b> '+self.eligibilty.to_s if self.eligibilty.present?
    string += '&nbsp&nbsp|&nbsp&nbsp<b>Time:</b> '+self.event_date_time.strftime("%D %r") if self.event_date_time.present?
    string += '<br><b>Registration Deadline:</b> '+self.registration_deadline.strftime("%D %r") if self.registration_deadline.present?
    string += '&nbsp&nbsp|&nbsp&nbsp<b>Venue:</b> '+self.venue.to_s if self.venue.present?
    string += '</h2>'
  end
  def combined
    string = info
    string += "<h1>Description</h1>" + self.description.to_s if self.description.present?
    string += "<h1>Rules</h1>" + self.rules.to_s if self.rules.present?
    string += "<h1>Judging</h1>" + self.judging.to_s if self.judging.present?
    string += "<h1>Prizes</h1>" + self.prizes.to_s if self.prizes.present?
    string += "<h1>Contact</h1>" + self.contact.to_s if self.contact.present?
    string
  end
  def mob_combined

    string = ""
    string +='<h2 align="center"><b>Team size limit:</b> '+self.team_size.to_s+' people'
    string +='&nbsp&nbsp|&nbsp&nbsp<b>Eligibility:</b> '+self.eligibilty.to_s if self.eligibilty.present?
    string += '&nbsp&nbsp|&nbsp&nbsp<b>Time:</b> '+self.event_date_time.strftime("%D %r") if self.event_date_time.present?
    string += '<br><b>Registration Deadline:</b> '+self.registration_deadline.strftime("%D %r") if self.registration_deadline.present?
    string += '&nbsp&nbsp|&nbsp&nbsp<b>Venue:</b> '+self.venue.to_s if self.venue.present?
    string += '</h2>'
    string += "<h1>Description</h1>" + self.description.to_s if self.description.present?
    string += "<h1>Rules</h1>" + self.rules.to_s if self.rules.present?
    string += "<h1>Judging</h1>" + self.judging.to_s if self.judging.present?
    string += "<h1>Prizes</h1>" + self.prizes.to_s if self.prizes.present?
    string += "<h1>Contact</h1>" + self.contact.to_s if self.contact.present?
    string
  end

  def total_participant_count
    self.participants.count.to_i + self.registrations.count.to_i
  end
  rails_admin do
    show do
      field :name
      field :participant_count do 
        formatted_value do
          bindings[:object].total_participant_count.to_s
        end
      end
      field :categories
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
      field :registrations
      field :teams
      field :participants
    end
    list do
      field :name
      field :categories
      field :users
      field :participant_count do 
        formatted_value do
          bindings[:object].total_participant_count.to_s
        end
      end
    end
    edit do
      field :name
      field :categories
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
