# == Schema Information
#
# Table name: players
#
#  id         :bigint(8)        not null, primary key
#  first_name :string
#  last_name  :string
#  rating     :decimal(15, 2)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ApplicationRecord
	
	has_and_belongs_to_many :leagues
	
	before_save :uppercase_name

	validates :first_name, presence: true, length: { maximum: 99 }  
	validates :last_name, presence: true, length: { maximum: 99 }  
	#validates :rating, presence: true, :default => 1500
	validates_numericality_of :rating, :greater_than_or_equal_to => 1000, :less_than_or_equal_to => 2000, :message => "not in range between 1000 and 2000"



	def name
		self.first_name + " " + self.last_name
	end

	# has this player played in a more recent match
	def has_more_recent_match?(match_date)
		c = Match.count_by_sql(["
			select
				count(*)
			from
				matches m
			where				
				? IN (m.player1_id, m.player2_id, m.player3_id, m.player4_id)												
				and m.match_date > ?
			", 
			self.id, 
			match_date])

		Rails.logger.debug c
		has_more_recent_match = c > 0
		Rails.logger.debug has_more_recent_match
		#Rails.logger.debug r.to_yaml
		
		if has_more_recent_match
			Rails.logger.debug "-"*100
			Rails.logger.debug "#{self.first_name} has a more recent match recorded, do NOT OVERWRITE rating"
			Rails.logger.debug "-"*100
		else  
			Rails.logger.debug "-"*100
			Rails.logger.debug "this is #{self.first_name}'s most recent match, SAVE this new rating"
			Rails.logger.debug "-"*100
		end

		has_more_recent_match
	end

	private
		def uppercase_name
			self.first_name.upcase!
			self.last_name.upcase!
		end
end
