# == Schema Information
#
# Table name: leagues
#
#  id         :bigint(8)        not null, primary key
#  org_id     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
