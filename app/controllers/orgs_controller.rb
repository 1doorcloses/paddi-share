class OrgsController < ApplicationController  
  before_action :authenticate_user!
  
  before_action :set_org, only: [:show, :edit, :update, :destroy]
  before_action :authorize_org

  after_action :verify_authorized

  


  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.all
    authorize User
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show    
  end

  # GET /orgs/new
  def new
    @org = Org.new    
  end

  # GET /orgs/1/edit
  def edit            
  end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)

    if @org.save
      redirect_to orgs_path, notice: 'Org was successfully created.'        
    else
      render :new        
    end    
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update    
    if @org.update(org_params)
      redirect_to orgs_path, notice: 'Org was successfully updated.'
    else
      render :edit
    end    
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy    
    @org.destroy
    redirect_to orgs_url, notice: 'Org was successfully destroyed.'      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.require(:org).permit(:name)
    end

    def authorize_org
      authorize Org
    end
end
