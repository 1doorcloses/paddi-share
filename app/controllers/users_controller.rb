class UsersController < ApplicationController  
  before_action :authenticate_user!
  
  before_action :authorize_admin_user
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
  end

  def savenew
    #raise 'here'
    @user = User.new(user_params)
    
    if @user.admin!
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end    
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def reset_system
    raise 'nope' unless current_user.id == 1
    Match.delete_all
    Player.delete_all
    linear = [
      Player.new(first_name:"SCOTT",last_name:"PECOR",rating:1970),
      Player.new(first_name:"TOM",last_name:"BELL",rating:1960),
      Player.new(first_name:"CURT",last_name:"SMITH",rating:1950),
      Player.new(first_name:"BYRON",last_name:"GABRIEL",rating:1940),
      Player.new(first_name:"MARK",last_name:"SHORT",rating:1930),
      Player.new(first_name:"VICTOR",last_name:"RECKMEYER",rating:1920),
      Player.new(first_name:"PELISEK",last_name:"MCKEEGAN",rating:1910),
      Player.new(first_name:"MARIANO",last_name:"LUNA",rating:1900),
      Player.new(first_name:"JOHN",last_name:"HARRIS",rating:1890),
      Player.new(first_name:"DAVID",last_name:"POLLACK",rating:1880),
      Player.new(first_name:"JONATHAN",last_name:"CANTWELL",rating:1870),
      Player.new(first_name:"SLADE",last_name:"MCGAURAN",rating:1860),
      Player.new(first_name:"WILL",last_name:"STALLE",rating:1850),
      Player.new(first_name:"JEFF",last_name:"FRANK",rating:1840),
      Player.new(first_name:"MIKE",last_name:"KELLY",rating:1830),
      Player.new(first_name:"PETER",last_name:"KLUG",rating:1820),
      Player.new(first_name:"AARON",last_name:"GARDNER",rating:1810),
      Player.new(first_name:"TREVOR",last_name:"D'SOUZA",rating:1800),
      Player.new(first_name:"STEVE",last_name:"SPADAFORA",rating:1790),
      Player.new(first_name:"ALEX",last_name:"STARRETT",rating:1780),
      Player.new(first_name:"BJORN",last_name:"SCHWEINSBERG",rating:1770),
      Player.new(first_name:"JOHN",last_name:"WATSON",rating:1760),
      Player.new(first_name:"JON",last_name:"BLOOM",rating:1750),
      Player.new(first_name:"DAN",last_name:"HALLER",rating:1740),
      Player.new(first_name:"TUCK",last_name:"MAXON",rating:1730),
      Player.new(first_name:"STEPHEN",last_name:"COX",rating:1720),
      Player.new(first_name:"GARD",last_name:"PECOR",rating:1710),
      Player.new(first_name:"ANDREW",last_name:"ROBBINS",rating:1700),
      Player.new(first_name:"JOHN",last_name:"RECKMEYER",rating:1690),
      Player.new(first_name:"MIKE",last_name:"HAYES",rating:1680),
      Player.new(first_name:"ERIC",last_name:"GAENSLEN",rating:1670),
      Player.new(first_name:"MICHAEL",last_name:"WHEELER",rating:1660),
      Player.new(first_name:"MOE",last_name:"DRANE",rating:1650),
      Player.new(first_name:"CHARLIE",last_name:"STALLE",rating:1640),
      Player.new(first_name:"STEVE",last_name:"HALLER",rating:1630),
      Player.new(first_name:"EDDIE",last_name:"BURKE",rating:1620),
      Player.new(first_name:"MILT",last_name:"FUEHRER",rating:1610),
      Player.new(first_name:"SCOTT",last_name:"GRENIER",rating:1600),
      Player.new(first_name:"ROBIN",last_name:"BUCKLEY",rating:1590),
      Player.new(first_name:"MITCH",last_name:"COX",rating:1580),
      Player.new(first_name:"KEVIN",last_name:"LAZOVIK",rating:1570),
      Player.new(first_name:"RICK",last_name:"READ",rating:1560),
      Player.new(first_name:"JIM",last_name:"BRUCE",rating:1550),
      Player.new(first_name:"KIP",last_name:"RANDALL",rating:1540),
      Player.new(first_name:"PETER",last_name:"BRENGEL",rating:1530),
      Player.new(first_name:"JON",last_name:"HERING",rating:1520),
      Player.new(first_name:"MIKE",last_name:"TEGGE",rating:1510),
      Player.new(first_name:"ANDY",last_name:"SCHUTZ",rating:1500),
      Player.new(first_name:"FREDDIE",last_name:"STALLE",rating:1490),
      Player.new(first_name:"QUINN",last_name:"ELLSWORTH",rating:1480),
      Player.new(first_name:"TJ",last_name:"HAUSKE",rating:1470),
      Player.new(first_name:"ANDY",last_name:"VAP",rating:1460),
      Player.new(first_name:"PETER",last_name:"MOEDE JR.",rating:1450),
      Player.new(first_name:"NICK",last_name:"WENNER",rating:1440),
      Player.new(first_name:"ROY",last_name:"WAGNER",rating:1430),
      Player.new(first_name:"STEVE",last_name:"BRUEMMER",rating:1420),
      Player.new(first_name:"KEITH",last_name:"BRUETT",rating:1410),
      Player.new(first_name:"DAVE",last_name:"KLENKE",rating:1400),
      Player.new(first_name:"RYAN",last_name:"HEATH",rating:1390),
      Player.new(first_name:"TRIP",last_name:"MOONEY",rating:1380),
      Player.new(first_name:"JOHN",last_name:"KRAMP",rating:1370),
      Player.new(first_name:"RANDY",last_name:"BORCHARDT",rating:1360),
      Player.new(first_name:"BILL",last_name:"FORD",rating:1350),
      Player.new(first_name:"CHARLIE",last_name:"WRIGHT",rating:1340),
      Player.new(first_name:"JASON",last_name:"DIAMOND",rating:1330),
      Player.new(first_name:"DAN",last_name:"LUKAS",rating:1320),
      Player.new(first_name:"BOB",last_name:"FRISCH",rating:1310),
      Player.new(first_name:"TOM",last_name:"BAUSCH",rating:1300),
      Player.new(first_name:"AMIN",last_name:"AFSARI",rating:1290),
      Player.new(first_name:"ANTHONY",last_name:"PECORARO",rating:1280),
      Player.new(first_name:"TOM",last_name:"SYLKE",rating:1270),
      Player.new(first_name:"HOWIE",last_name:"HAAS",rating:1260),
      Player.new(first_name:"KYLE",last_name:"TRIMBLE",rating:1250),
      Player.new(first_name:"JOE",last_name:"MATTERA",rating:1240),
      Player.new(first_name:"DAVID",last_name:"HERMANNY",rating:1230),
      Player.new(first_name:"KEN",last_name:"K. BRENGEL",rating:1220),
      Player.new(first_name:"PAUL",last_name:"TILLEMAN",rating:1210),
      Player.new(first_name:"GRANT",last_name:"BURRALL",rating:1200),
      Player.new(first_name:"TIM",last_name:"T. BURKE",rating:1190),
      Player.new(first_name:"BOB",last_name:"SHARPE",rating:1180),
      Player.new(first_name:"RICK",last_name:"STRICKROOT",rating:1170),
      Player.new(first_name:"JOHN",last_name:"BURESH",rating:1160),
      Player.new(first_name:"PATRICK",last_name:"TEVLIN",rating:1150),
      Player.new(first_name:"PAUL",last_name:"DESLONGCHAMPS",rating:1140),
      Player.new(first_name:"BRINT",last_name:"ROBBINS",rating:1130),
      Player.new(first_name:"PAUL",last_name:"LISI",rating:1120),
      Player.new(first_name:"ERIK",last_name:"ALMEIDA",rating:1110),
      Player.new(first_name:"JERRY",last_name:"HANSON",rating:1100),
      Player.new(first_name:"CAMERON",last_name:"REDDEN",rating:1090),
      Player.new(first_name:"SARAH",last_name:"STARRETT",rating:1080),
      Player.new(first_name:"MARIO",last_name:"GONZALES",rating:1070),
      Player.new(first_name:"MIKE",last_name:"TREPTOW",rating:1060),
      Player.new(first_name:"GEOFF",last_name:"WARD",rating:1050),
      Player.new(first_name:"ETHAN",last_name:"ELSER",rating:1040),
      Player.new(first_name:"TERRY",last_name:"LONGBOW",rating:1030),
      Player.new(first_name:"CLARENCE",last_name:"WORLEY",rating:1020)
    ]

    org = Org.where(name:"The Town Club").first!
    league = org.leagues.first
    linear.each do |p|
      p.save!
      league.players << p
    end
    redirect_to users_path, :notice => "Success"
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:role)
  end

end
