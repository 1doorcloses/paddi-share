class RemoveRatingChangeFromMatches < ActiveRecord::Migration[5.2]
  def change
  	remove_column :matches, :rating_change
  end
end
