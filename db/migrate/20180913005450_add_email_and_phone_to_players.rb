class AddEmailAndPhoneToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :email, :string
    add_column :players, :phone, :string
  end
end
