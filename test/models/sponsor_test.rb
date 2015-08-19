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
#  url        :string
#

require 'test_helper'

class SponsorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
