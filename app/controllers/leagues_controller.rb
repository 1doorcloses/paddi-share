class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy, :assign]
  before_action :set_org

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.where(org_id:@org.id)
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show    
  end

  def assign
    if request.post?

      player_id = params[:player_id].to_i

      if player_id == -1
        flash[:error] = "Please choose a player and try again."
        redirect_back(fallback_location: org_league_path(@org,@league)) and return
      end

      player = Player.find(player_id)

      if player.leagues.include?(@league)
        flash[:error] = "Player already in this league."
        redirect_back(fallback_location: org_league_path(@org,@league)) and return
      end

      
      @league.players << player

      flash[:notice] = "Player successfully added to league."
      redirect_to org_league_path(@org,@league)
    end

    if request.delete?
      player = Player.find(params[:player_id].to_i)
      @league.players.delete(player)
      flash[:notice] = "Player removed from league."
      redirect_to org_league_path(@org,@league)
    end
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)
    @league.org = @org

    respond_to do |format|
      if @league.save
        format.html { redirect_to org_league_path(@org,@league), notice: 'League was successfully created.' }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to org_league_path(@org,@league), notice: 'League was successfully updated.' }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to org_leagues_path(@org), notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name, :rating)
    end

    def set_org
      @org = Org.find(params[:org_id])
    end
end
