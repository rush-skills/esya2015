# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :integer
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable:registerable,
  devise  :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :event_admins
  has_many :events, through: :event_admins

  extend Enumerize
  enumerize :role, in: {:user => 1,:event_head => 2, :admin => 3, :super_admin => 4}, default: :user

  # validates :name, presence: true
  validates :email, presence: true

  def to_s
    self.name
  end

  def self.from_omniauth(auth)
    if auth.info.email.split("@").last == "iiitd.ac.in"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        # user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        # user.image = auth.info.image # assuming the user model has an image
      end
    else
      Rails.logger.warn "Non IIITD access from "+ auth.info.email.to_s
      nil
    end
  end

  rails_admin do
    show do
      field :name
      field :email
      field :role
      field :events
      field :sign_in_count
      field :last_sign_in_at
      field :last_sign_in_ip
      field :current_sign_in_at
      field :current_sign_in_ip
    end
    list do
      field :name
      field :email
      field :role
    end
    edit do
      field :name
      field :email
      field :role
      # field :password
      # field :password_confirmation
      field :events
    end
  end
end
