# == Schema Information
#
# Table name: static_pages
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StaticPage < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true
  validates :description, presence: true

  def to_s
    self.name.to_s
  end

  def short_code
    self.name.squish.downcase.tr(" ","_")
  end

  rails_admin do
    show do
      field :name
      field :description do
        pretty_value do
          bindings[:object].description.html_safe
        end
      end
    end
    list do
      field :name
    end
    edit do
      field :name
      field :description, :wysihtml5 do
          config_options toolbar: {
            fa: true,
            image: false,
            link: false
          } # use font-awesome instead of glyphicon, disable images
        end
    end
  end
end
