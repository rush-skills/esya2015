# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  role       :integer
#  provider   :string
#  uid        :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
