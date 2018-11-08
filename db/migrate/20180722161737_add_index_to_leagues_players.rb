class AddIndexToLeaguesPlayers < ActiveRecord::Migration[5.2]
  def change
  	add_index :leagues_players, [:league_id, :player_id], :unique => true
  end
end
