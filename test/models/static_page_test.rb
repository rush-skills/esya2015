# == Schema Information
#
# Table name: static_pages
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#

require 'test_helper'

class StaticPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
