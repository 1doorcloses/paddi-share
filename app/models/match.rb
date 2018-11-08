# == Schema Information
#
# Table name: matches
#
#  id                   :bigint(8)        not null, primary key
#  played_at            :datetime         not null
#  player1_id           :integer          not null
#  player2_id           :integer          not null
#  player3_id           :integer          not null
#  player4_id           :integer          not null
#  player1_rating_start :decimal(15, 2)   not null
#  player2_rating_start :decimal(15, 2)   not null
#  player3_rating_start :decimal(15, 2)   not null
#  player4_rating_start :decimal(15, 2)   not null
#  player1_rating_end   :decimal(15, 2)   not null
#  player2_rating_end   :decimal(15, 2)   not null
#  player3_rating_end   :decimal(15, 2)   not null
#  player4_rating_end   :decimal(15, 2)   not null
#  team1_set1_games     :integer          default(0), not null
#  team1_set2_games     :integer          default(0), not null
#  team1_set3_games     :integer          default(0), not null
#  team2_set1_games     :integer          default(0), not null
#  team2_set2_games     :integer          default(0), not null
#  team2_set3_games     :integer          default(0), not null
#  k_value              :integer          not null
#  notes                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  team1_rating_change  :decimal(15, 2)   not null
#  team2_rating_change  :decimal(15, 2)   not null
#

class Match < ApplicationRecord	

	# status
  @K_VALUE = 60  
  class << self
    attr_reader :K_VALUE
  end

	paginates_per  10 #kaminari

	#
	# https://guides.rubyonrails.org/active_record_callbacks.html
	#
	#before_validation :calculate_new_match, if: :new_match_conditions_met?
	#before_validation :calculate_update_match, if: :existing_match_conditions_met?
	before_save :calculate_new_match, if: :new_match_conditions_met?
	before_save :calculate_update_match, if: :existing_match_conditions_met?	
	before_destroy :undo_players_rating_change	
				
	validates :played_at, :player1_id, :player2_id, :player3_id, :player4_id, presence: true
	validate :games_greater_than0
	validate :players_must_be_all_unique	

	belongs_to :player1, class_name:"Player", autosave: true #, foreign_key: :player1_id
	belongs_to :player2, class_name:"Player", autosave: true
	belongs_to :player3, class_name:"Player", autosave: true
	belongs_to :player4, class_name:"Player", autosave: true		

	def winning_team
		team1_sets_won = 0
		team2_sets_won = 0

		team1_sets_won += 1 if self.team1_set1_games > self.team2_set1_games
		team2_sets_won += 1 if self.team1_set1_games < self.team2_set1_games

		team1_sets_won += 1 if self.team1_set2_games > self.team2_set2_games
		team2_sets_won += 1 if self.team1_set2_games < self.team2_set2_games

		team1_sets_won += 1 if self.team1_set3_games > self.team2_set3_games
		team2_sets_won += 1 if self.team1_set3_games < self.team2_set3_games
		
		return 0 if team1_sets_won == team2_sets_won
		return 1 if team1_sets_won > team2_sets_won
		return 2 if team1_sets_won < team2_sets_won
	end

	def get_score
		r = ""
		r += self.team1_set1_games.to_s + "-" + self.team2_set1_games.to_s
		r += ", " + self.team1_set2_games.to_s + "-" + self.team2_set2_games.to_s if self.team1_set2_games > 0 || self.team2_set2_games > 0
		r += ", " + self.team1_set3_games.to_s + "-" + self.team2_set3_games.to_s if self.team1_set3_games > 0 || self.team2_set3_games > 0
		r
	end

	def calc_team1_games
		t = 0
		t += self.team1_set1_games if self.team1_set1_games.present?
		t += self.team1_set2_games if self.team1_set2_games.present?
		t += self.team1_set3_games if self.team1_set3_games.present?
		t
	end

	def calc_team2_games
		t = 0
		t += self.team2_set1_games if self.team2_set1_games.present?
		t += self.team2_set2_games if self.team2_set2_games.present?
		t += self.team2_set3_games if self.team2_set3_games.present?
		t
	end

	def existing_match_conditions_met?
		self.new_record? == false# && we_good_to_go?
	end

	def new_match_conditions_met?
		self.new_record?# && we_good_to_go?
	end

	def we_good_to_go?
		self.player1_id.present? && self.player2_id.present? && self.player3_id.present? && self.player4_id.present? && games_greater_than0		
	end

	def calc_elo(p1_rating,p2_rating,p3_rating,p4_rating,team1_games_total,team2_games_total,k=60)

		aTeamRating = (p1_rating + p2_rating) / 2.to_f
		bTeamRating = (p3_rating + p4_rating) / 2.to_f

		#logger.debug "aTeamRating => " + aTeamRating.to_s

		#aTeamRating = aTeamRating.round(2)
		#bTeamRating = bTeamRating.round(2)

		# ELO Math 
		qA = 10 ** (aTeamRating / 400)
		qB = 10 ** (bTeamRating / 400)

		#qA = qA.round(2)
		#qB = qB.round(2)

		eA = qA / (qA + qB);
		eB = qB / (qA + qB);

		#eA = eA.round(2)
		#eB = eB.round(2)

		totalGames = team1_games_total + team2_games_total;

		#totalGames = totalGames.to_f.round(2)

		aTeamRatingDelta = 50 * ((team1_games_total - (eA * totalGames)) / totalGames);
		bTeamRatingDelta = 50 * ((team2_games_total - (eB * totalGames)) / totalGames);
		
		p1_rating_end = p1_rating + aTeamRatingDelta;
		p2_rating_end = p2_rating + aTeamRatingDelta;
		p3_rating_end = p3_rating + bTeamRatingDelta;
		p4_rating_end = p4_rating + bTeamRatingDelta;

		#p1_rating = p1_rating.round(2)
		#p2_rating = p2_rating.round(2)
		#p3_rating = p3_rating.round(2)
		#p4_rating = p4_rating.round(2)

		{
			k_value: k,
			p1_rating_start: p1_rating,
			p2_rating_start: p2_rating,
			p3_rating_start: p3_rating,
			p4_rating_start: p4_rating,
			p1_rating_end: p1_rating_end,
			p2_rating_end: p2_rating_end,
			p3_rating_end: p3_rating_end,
			p4_rating_end: p4_rating_end,
			team1_rating_delta: aTeamRatingDelta,
			team2_rating_delta: bTeamRatingDelta
		}
	end

	private

		def players_must_be_all_unique
			players = [self.player1_id,self.player2_id,self.player3_id,self.player4_id]
			if !(players == players.uniq)
				errors.add(:base, "All players must be unique")
			end
		end

		def games_greater_than0
			if !(self.team1_set1_games > 0 || self.team2_set1_games > 0)
				errors.add(:base, "Must play at least 1 game in the first set")
			end
		end

		def games
			if !games_greater_than0
      	errors.add(:base, "Must play at least 1 game in the first set")
			end
		end

		def calculate_update_match

			raise 'cant change players when updating' if self.player1_id_changed?
			raise 'cant change players when updating' if self.player2_id_changed?
			raise 'cant change players when updating' if self.player3_id_changed?
			raise 'cant change players when updating' if self.player4_id_changed?

			###if self.player1_id_changed? #if player1 has changed, we have no choice but to go fetch thier current rating				
				###p1_rating_s = self.player1.rating				
			###else #if player1 is the same as before, use thier rating at the time of this match
				p1_rating_s = self.player1_rating_start.dup 				
			###end

			###if self.player2_id_changed?
				###p2_rating_s = self.player2.rating				
			###else 
				p2_rating_s = self.player2_rating_start.dup 				
			###end

			###if self.player3_id_changed?
				###p3_rating_s = self.player3.rating				
			###else 
				p3_rating_s = self.player3_rating_start.dup 				
			###end

			###if self.player4_id_changed?
				###p4_rating_s = self.player4.rating				
			###else 
				p4_rating_s = self.player4_rating_start.dup 				
			###end	

			#back out the previous rating impact	
			self.player1.rating -= self.team1_rating_change
			self.player2.rating -= self.team1_rating_change
			self.player3.rating -= self.team2_rating_change
			self.player4.rating -= self.team2_rating_change				

			results = calc_elo(p1_rating_s,
	    									p2_rating_s,
	    									p3_rating_s,
	    									p4_rating_s,
	    									calc_team1_games,
	    									calc_team2_games,
	    									Match.K_VALUE)		

	    set_results(results)
		end

		def calculate_new_match			
		
	    results = calc_elo(self.player1.rating.dup,
	    									self.player2.rating.dup,
	    									self.player3.rating.dup,
	    									self.player4.rating.dup,
	    									calc_team1_games,
	    									calc_team2_games,
	    									Match.K_VALUE)

	    set_results(results)	    
	  end

	  def set_results(results) #, save_playerl_rating=true, save_player2_rating=true, save_player3_rating=true, save_player4_rating=true)

	    self.player1_rating_start = results[:p1_rating_start]
	    self.player2_rating_start = results[:p2_rating_start]
	    self.player3_rating_start = results[:p3_rating_start]
	    self.player4_rating_start = results[:p4_rating_start]
	  
	    self.player1_rating_end = results[:p1_rating_end]
	    self.player2_rating_end = results[:p2_rating_end]
	    self.player3_rating_end = results[:p3_rating_end]
	    self.player4_rating_end = results[:p4_rating_end]

	    self.k_value = results[:k_value]

			# does player have a more recent match? if so, do NOT overwrite player rating
			#save_playerl_rating = !self.player1.has_more_recent_match?(self.played_at)				
			#save_player2_rating = !self.player2.has_more_recent_match?(self.played_at)				
			#save_player3_rating = !self.player3.has_more_recent_match?(self.played_at)				
			#save_player4_rating = !self.player4.has_more_recent_match?(self.played_at)										    

	    #self.player1.rating = results[:p1_rating_end] #if save_playerl_rating
	    #self.player2.rating = results[:p2_rating_end] #if save_player2_rating
	    #self.player3.rating = results[:p3_rating_end] #if save_player3_rating
	    #self.player4.rating = results[:p4_rating_end] #if save_player4_rating	    
	    
	    self.team1_rating_change = results[:team1_rating_delta]
	    self.team2_rating_change = results[:team2_rating_delta]

			self.player1.rating += self.team1_rating_change
			self.player2.rating += self.team1_rating_change
			self.player3.rating += self.team2_rating_change
			self.player4.rating += self.team2_rating_change	    
	  end


		def undo_players_rating_change
			self.player1.rating -= self.team1_rating_change
			self.player2.rating -= self.team1_rating_change
			self.player3.rating -= self.team2_rating_change
			self.player4.rating -= self.team2_rating_change
			
			self.player1.save!
			self.player2.save!
			self.player3.save!
			self.player4.save!
		end
end
