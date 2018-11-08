class ReportsController < ApplicationController  
  
  before_action :authenticate_user!
  before_action :authorize_admin_user

  before_action :set_match, only: [:show, :edit, :update, :destroy]
  
  after_action :verify_authorized

    
  def reports

    @results = Match.find_by_sql ["
        select 
          DATE_TRUNC('day',(played_at::TIMESTAMPTZ AT TIME ZONE INTERVAL '#{Time.zone.now.formatted_offset}')) as match_date,                     
          sum(team1_set1_games + team1_set2_games + team1_set3_games + team2_set1_games + team2_set2_games + team2_set3_games)/count(matches) as avg_games_per_match
        from 
          matches 
        group by 
          match_date
        order by 
          match_date asc"]
  end

end