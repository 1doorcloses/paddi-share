# == Schema Information
#
# Table name: matches
#
#  id                   :bigint(8)        not null, primary key
#  played_at            :datetime         not null
#  player1_id           :integer          not null
#  player2_id           :integer          not null
#  player3_id           :integer          not null
#  player4_id           :integer          not null
#  player1_rating_start :decimal(15, 2)   not null
#  player2_rating_start :decimal(15, 2)   not null
#  player3_rating_start :decimal(15, 2)   not null
#  player4_rating_start :decimal(15, 2)   not null
#  player1_rating_end   :decimal(15, 2)   not null
#  player2_rating_end   :decimal(15, 2)   not null
#  player3_rating_end   :decimal(15, 2)   not null
#  player4_rating_end   :decimal(15, 2)   not null
#  team1_set1_games     :integer          default(0), not null
#  team1_set2_games     :integer          default(0), not null
#  team1_set3_games     :integer          default(0), not null
#  team2_set1_games     :integer          default(0), not null
#  team2_set2_games     :integer          default(0), not null
#  team2_set3_games     :integer          default(0), not null
#  k_value              :integer          not null
#  notes                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  team1_rating_change  :decimal(15, 2)   not null
#  team2_rating_change  :decimal(15, 2)   not null
#

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
