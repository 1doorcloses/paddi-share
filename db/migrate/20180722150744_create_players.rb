class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :rating, :precision => 15, scale: 2
      t.integer :user_id

      t.timestamps
    end
  end
end
