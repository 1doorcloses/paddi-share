class RemoveUserColsFromMatches < ActiveRecord::Migration[5.2]
  def change
  	remove_column :matches, :user_id
  	remove_column :matches, :user_name
  end
end
