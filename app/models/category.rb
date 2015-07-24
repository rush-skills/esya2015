# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :events
  validates :name, presence: true
  def to_s
    self.name
  end
  rails_admin do
      visible false
  end
end
