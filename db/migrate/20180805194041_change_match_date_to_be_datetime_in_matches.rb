class ChangeMatchDateToBeDatetimeInMatches < ActiveRecord::Migration[5.2]
  def change
  	change_column :matches, :match_date, :datetime
  	rename_column :matches, :match_date, :played_at
  end
end
