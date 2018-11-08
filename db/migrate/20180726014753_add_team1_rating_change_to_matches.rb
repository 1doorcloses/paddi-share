class AddTeam1RatingChangeToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :team1_rating_change, :decimal, :precision => 15, scale: 2, :null => false
  end
end
