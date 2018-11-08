class MatchesController < ApplicationController  
  
  before_action :authenticate_user!
  before_action :authorize_admin_user

  before_action :set_match, only: [:show, :edit, :update, :destroy]
  
  after_action :verify_authorized

  
  # GET /matches  
  def index
    if params[:player_id].present?
      pid = params[:player_id]
      @player = Player.find(pid.to_i)
      @matches = Match.where("player1_id = ? or player2_id = ? or player3_id = ? or player4_id = ?",pid,pid,pid,pid).order("played_at DESC").page params[:page]
    else
      @matches = Match.order("played_at DESC").page params[:page]
    end
    @players = Player.order('rating DESC')
    #authorize User
  end

  # GET /matches/1  
  def show    
  end

  # GET /matches/new
  def new
    @match = Match.new  
    @players = Player.order('rating DESC')  
  end

  # GET /matches/1/edit
  def edit        
    @players = Player.order('rating DESC')    
  end

  # POST /matches  
  def create
    @match = Match.new(match_params)
    now = DateTime.now
    #@match.played_at = @match.played_at.change({ hour: now.hour, min: now.min, sec: now.sec })    
    #@match.played_at = Date.current #see application.rb for configured time_zone      

    if @match.save
      redirect_to matches_path, notice: 'Match was successfully created.'        
    else
      @players = Player.order('rating DESC') 
      render :new        
    end    
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update        
    @players = Player.order('rating DESC')

    if @match.update(match_params) 
      redirect_to matches_path, notice: 'Match was successfully updated.'
    else
      render :edit
    end    
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy    
    @match.destroy
    redirect_to matches_url, notice: 'Match was successfully destroyed.'      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:player1_id,:player2_id,:player3_id,:player4_id,
                                        :team1_set1_games,:team1_set2_games,:team1_set3_games,
                                        :team2_set1_games,:team2_set2_games,:team2_set3_games,
                                        :played_at)
    end
    

    
end
