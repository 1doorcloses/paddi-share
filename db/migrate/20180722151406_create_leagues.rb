class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.integer :org_id
      t.string :name

      t.timestamps
    end
  end
end
