# == Schema Information
#
# Table name: organizers
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organizer < ActiveRecord::Base
  has_paper_trail
  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader
  attr_accessor :photo_cache, :remove_photo

  def to_s
    self.name.to_s
  end

  def short_code
    self.name.squish.downcase.tr(" ","_")
  end

  rails_admin do
    show do
      field :photo
    end
    list do
      field :photo
    end
    edit do
      field :photo
    end
  end

end
