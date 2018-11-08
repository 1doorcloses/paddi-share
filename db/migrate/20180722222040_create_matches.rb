class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.date :match_date, :null => false

      t.integer :player1_id, :null => false
      t.integer :player2_id, :null => false
      t.integer :player3_id, :null => false
      t.integer :player4_id, :null => false

      t.decimal :player1_rating_start, :precision => 15, scale: 2, :null => false
      t.decimal :player2_rating_start, :precision => 15, scale: 2, :null => false
      t.decimal :player3_rating_start, :precision => 15, scale: 2, :null => false
      t.decimal :player4_rating_start, :precision => 15, scale: 2, :null => false

      t.decimal :player1_rating_end, :precision => 15, scale: 2, :null => false
      t.decimal :player2_rating_end, :precision => 15, scale: 2, :null => false
      t.decimal :player3_rating_end, :precision => 15, scale: 2, :null => false
      t.decimal :player4_rating_end, :precision => 15, scale: 2, :null => false

      t.decimal :rating_change, :precision => 15, scale: 2, :null => false

			t.integer :team1_set1_games, :limit => 1, :default => 0, :null => false 
			t.integer :team1_set2_games, :limit => 1, :default => 0, :null => false 
			t.integer :team1_set3_games, :limit => 1, :default => 0, :null => false 
			
			t.integer :team2_set1_games, :limit => 1, :default => 0, :null => false 
			t.integer :team2_set2_games, :limit => 1, :default => 0, :null => false 
			t.integer :team2_set3_games, :limit => 1, :default => 0, :null => false 


      t.integer :k_value, :limit => 2, :null => false
      t.string :notes

      t.integer :user_id, :null => false
      t.string :user_name, :null => false

      t.timestamps
    end
  end
end
