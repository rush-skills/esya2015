# == Schema Information
#
# Table name: sponsors
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sponsor < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true
  validates :category, presence: true
  validates :image, presence: true

  mount_uploader :image, PhotoUploader
  attr_accessor :image_cache, :remove_image

  extend Enumerize
  enumerize :category, in: ["Title Sponsor","Associate Sponsor","Category Sponsor","Event Partner","Partner","Media Partner","Food and Beverages Partner","Hackathon Partner","Workshop Partner"]

  def to_s
    self.name.to_s
  end

  def short_code
    self.name.squish.downcase.tr(" ","_")
  end

  # def combined
  #   string = ""
  #   string += '<div class="image-center"><img height="250px" src="'+self.image.url+'"></div>' if self.image.present?
  #   string += self.description.to_s
  # end
  rails_admin do
    show do
      field :name
      field :image
      field :category
    end
    list do
      field :name
      field :category
    end
    edit do
      field :name
      field :image
      field :category
    end
  end
end
