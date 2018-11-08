# == Schema Information
#
# Table name: players
#
#  id         :bigint(8)        not null, primary key
#  first_name :string
#  last_name  :string
#  rating     :decimal(15, 2)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
