class AddTeam2RatingChangeToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :team2_rating_change, :decimal, :precision => 15, scale: 2, :null => false
  end
end
