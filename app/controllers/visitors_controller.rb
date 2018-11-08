class VisitorsController < ApplicationController
	include ApplicationHelper  

	def ladders
		@league = League.first
		@players = @league.players.order('rating DESC')
	end

	def scoreboard
    if params[:player_id].present?
      pid = params[:player_id]
      @player = Player.find(pid.to_i)
      @matches = Match.where("player1_id = ? or player2_id = ? or player3_id = ? or player4_id = ?",pid,pid,pid,pid).order("played_at DESC").page params[:page]
    else
      @matches = Match.order("played_at DESC").page params[:page]
    end
    @players = Player.order('rating DESC')
	end


	def simulator
		@results = false
		#@league = League.first
		#@players = @league.players.order('rating DESC')
		@players = Player.order('rating DESC')
		@match = Match.new
		
		unless request.get?
			@match = Match.new(match_params)
	    now = DateTime.now
	    @match.played_at = now	    

	    if @match.validate
	    	@results = @match.calc_elo(@match.player1.rating.dup,
										@match.player2.rating.dup,
										@match.player3.rating.dup,
										@match.player4.rating.dup,
										@match.calc_team1_games,
										@match.calc_team2_games,
										Match.K_VALUE)	

	    	@player_ids = [@match.player1.id,@match.player2.id,@match.player3.id,@match.player4.id]

	    	@new_ladder = @players.dup
	    	@new_ladder.each do |n|	    	
	    		n.rating += @results[:team1_rating_delta] if n.id == @match.player1.id
	    		n.rating += @results[:team1_rating_delta] if n.id == @match.player2.id
	    		n.rating += @results[:team2_rating_delta] if n.id == @match.player3.id
	    		n.rating += @results[:team2_rating_delta] if n.id == @match.player4.id			
	    	end
	    	@new_ladder = @new_ladder.sort_by {|obj| -obj.rating}
	    	
	      #redirect_to matches_path, notice: 'Match was successfully calculated.' 
	      flash.now[:notice] = "Match was successfully calculated."       	      	        
	    end  	  	   	
		end
		
	end

	def simulator2
		
		@player1 = -1
		@player2 = -1
		@player3 = -1
		@player4 = -1
		@team1_games = -1
		@team2_games = -1
		@results = false

		@players = get_players

		@players.each_with_index do |p,i| 
			p.id = i+1
		end

		if request.post?			
			
			@player1 = params[:match][:player1_id].to_i
			@player2 = params[:match][:player2_id].to_i
			@player3 = params[:match][:player3_id].to_i
			@player4 = params[:match][:player4_id].to_i
			@team1_set1_games = params[:match][:team1_set1_games].to_i
			@team1_set2_games = params[:match][:team1_set2_games].to_i
			@team1_set3_games = params[:match][:team1_set3_games].to_i
			@team2_set1_games = params[:match][:team2_set1_games].to_i
			@team2_set2_games = params[:match][:team2_set2_games].to_i
			@team2_set3_games = params[:match][:team2_set3_games].to_i

			if @player1 > -1 && @player2 > -1 && @player3 > -1 && @player4 > -1 && @team1_set1_games > -1 && @team2_set1_games > -1 && (@team1_set1_games > 0 || @team2_set1_games > 0)
				
				@new_ladder = Marshal.load(Marshal.dump(@players))

				@p1 = @new_ladder[@player1]
				@p2 = @new_ladder[@player2]
				@p3 = @new_ladder[@player3]
				@p4 = @new_ladder[@player4]

				@team1_total_games = @team1_set1_games
				@team1_total_games += @team1_set2_games if @team1_set2_games > -1
				@team1_total_games += @team1_set3_games if @team1_set3_games > -1

				@team2_total_games = @team2_set1_games
				@team2_total_games += @team2_set2_games if @team2_set2_games > -1
				@team2_total_games += @team2_set3_games if @team2_set3_games > -1


				calc_match(@p1,@p2,@p3,@p4,@team1_total_games,@team2_total_games)

				@new_ladder = @new_ladder.sort_by {|obj| -obj.rating}

				@results = true
			else
				flash.now[:error] = "Please enter required values and try again."
			end

			
		end


	end

	def get_players
		bell = [
				Player.new(first_name:"SCOTT",last_name:"PECOR",rating:1965),
				Player.new(first_name:"TOM",last_name:"BELL",rating:1911),
				Player.new(first_name:"CURT",last_name:"SMITH",rating:1876),
				Player.new(first_name:"BYRON",last_name:"B. GABRIEL",rating:1850),
				Player.new(first_name:"MARK",last_name:"SHORT",rating:1829),
				Player.new(first_name:"VICTOR",last_name:"V. RECKMEYER",rating:1811),
				Player.new(first_name:"PELISEK",last_name:"MCKEEGAN",rating:1795),
				Player.new(first_name:"MARIANO",last_name:"LUNA",rating:1781),
				Player.new(first_name:"JOHN",last_name:"HARRIS",rating:1768),
				Player.new(first_name:"DAVID",last_name:"POLLACK",rating:1756),
				Player.new(first_name:"JONATHAN",last_name:"CANTWELL",rating:1745),
				Player.new(first_name:"SLADE",last_name:"MCGAURAN",rating:1735),
				Player.new(first_name:"WILL",last_name:"W. STALLE",rating:1725),
				Player.new(first_name:"JEFF",last_name:"FRANK",rating:1716),
				Player.new(first_name:"MIKE",last_name:"KELLY",rating:1707),
				Player.new(first_name:"PETER",last_name:"KLUG",rating:1699),
				Player.new(first_name:"AARON",last_name:"GARDNER",rating:1691),
				Player.new(first_name:"TREVOR",last_name:"D'SOUZA",rating:1683),
				Player.new(first_name:"STEVE",last_name:"SPADAFORA",rating:1676),
				Player.new(first_name:"ALEX",last_name:"STARRETT",rating:1668),
				Player.new(first_name:"BJORN",last_name:"SCHWEINSBERG",rating:1661),
				Player.new(first_name:"JOHN",last_name:"WATSON",rating:1654),
				Player.new(first_name:"JON",last_name:"BLOOM",rating:1648),
				Player.new(first_name:"DAN",last_name:"HALLER",rating:1641),
				Player.new(first_name:"TUCK",last_name:"T. MAXON",rating:1635),
				Player.new(first_name:"STEPHEN",last_name:"S. COX",rating:1629),
				Player.new(first_name:"GARD",last_name:"G. PECOR",rating:1623),
				Player.new(first_name:"ANDREW",last_name:"A. ROBBINS",rating:1617),
				Player.new(first_name:"JOHN",last_name:"J. RECKMEYER",rating:1611),
				Player.new(first_name:"MIKE",last_name:"HAYES",rating:1605),
				Player.new(first_name:"ERIC",last_name:"GAENSLEN",rating:1599),
				Player.new(first_name:"MICHAEL",last_name:"WHEELER",rating:1594),
				Player.new(first_name:"MOE",last_name:"DRANE",rating:1588),
				Player.new(first_name:"CHARLIE",last_name:"C. STALLE",rating:1582),
				Player.new(first_name:"STEVE",last_name:"HALLER",rating:1577),
				Player.new(first_name:"EDDIE",last_name:"E. BURKE",rating:1572),
				Player.new(first_name:"MILT",last_name:"FUEHRER",rating:1566),
				Player.new(first_name:"SCOTT",last_name:"GRENIER",rating:1561),
				Player.new(first_name:"ROBIN",last_name:"BUCKLEY",rating:1556),
				Player.new(first_name:"MITCH",last_name:"M. COX",rating:1551),
				Player.new(first_name:"KEVIN",last_name:"LAZOVIK",rating:1546),
				Player.new(first_name:"RICK",last_name:"R. READ",rating:1540),
				Player.new(first_name:"JIM",last_name:"BRUCE",rating:1535),
				Player.new(first_name:"KIP",last_name:"RANDALL",rating:1530),
				Player.new(first_name:"PETER",last_name:"P. BRENGEL",rating:1525),
				Player.new(first_name:"JON",last_name:"HERING",rating:1520),
				Player.new(first_name:"MIKE",last_name:"TEGGE",rating:1515),
				Player.new(first_name:"ANDY",last_name:"SCHUTZ",rating:1510),
				Player.new(first_name:"FREDDIE",last_name:"F. STALLE",rating:1505),
				Player.new(first_name:"QUINN",last_name:"ELLSWORTH",rating:1500),
				Player.new(first_name:"TJ",last_name:"HAUSKE",rating:1495),
				Player.new(first_name:"ANDY",last_name:"VAP",rating:1490),
				Player.new(first_name:"PETER",last_name:"P. MOEDE JR.",rating:1485),
				Player.new(first_name:"NICK",last_name:"WENNER",rating:1480),
				Player.new(first_name:"ROY",last_name:"WAGNER",rating:1475),
				Player.new(first_name:"STEVE",last_name:"BRUEMMER",rating:1470),
				Player.new(first_name:"KEITH",last_name:"BRUETT",rating:1465),
				Player.new(first_name:"DAVE",last_name:"KLENKE",rating:1460),
				Player.new(first_name:"RYAN",last_name:"HEATH",rating:1454),
				Player.new(first_name:"TRIP",last_name:"MOONEY",rating:1449),
				Player.new(first_name:"JOHN",last_name:"KRAMP",rating:1444),
				Player.new(first_name:"RANDY",last_name:"BORCHARDT",rating:1439),
				Player.new(first_name:"BILL",last_name:"FORD",rating:1434),
				Player.new(first_name:"CHARLIE",last_name:"WRIGHT",rating:1428),
				Player.new(first_name:"JASON",last_name:"DIAMOND",rating:1423),
				Player.new(first_name:"DAN",last_name:"LUKAS",rating:1418),
				Player.new(first_name:"BOB",last_name:"FRISCH",rating:1412),
				Player.new(first_name:"TOM",last_name:"BAUSCH",rating:1406),
				Player.new(first_name:"AMIN",last_name:"AFSARI",rating:1401),
				Player.new(first_name:"ANTHONY",last_name:"PECORARO",rating:1395),
				Player.new(first_name:"TOM",last_name:"SYLKE",rating:1389),
				Player.new(first_name:"HOWIE",last_name:"HAAS",rating:1383),
				Player.new(first_name:"KYLE",last_name:"TRIMBLE",rating:1377),
				Player.new(first_name:"JOE",last_name:"MATTERA",rating:1371),
				Player.new(first_name:"DAVID",last_name:"HERMANNY",rating:1365),
				Player.new(first_name:"KEN",last_name:"K. BRENGEL",rating:1359),
				Player.new(first_name:"PAUL",last_name:"TILLEMAN",rating:1352),
				Player.new(first_name:"GRANT",last_name:"BURRALL",rating:1346),
				Player.new(first_name:"TIM",last_name:"T. BURKE",rating:1339),
				Player.new(first_name:"BOB",last_name:"SHARPE",rating:1332),
				Player.new(first_name:"RICK",last_name:"STRICKROOT",rating:1324),
				Player.new(first_name:"JOHN",last_name:"BURESH",rating:1317),
				Player.new(first_name:"PATRICK",last_name:"TEVLIN",rating:1309),
				Player.new(first_name:"PAUL",last_name:"DESLONGCHAMPS",rating:1301),
				Player.new(first_name:"BRINT",last_name:"B. ROBBINS",rating:1293),
				Player.new(first_name:"PAUL",last_name:"LISI",rating:1284),
				Player.new(first_name:"ERIK",last_name:"ALMEIDA",rating:1275),
				Player.new(first_name:"JERRY",last_name:"HANSON",rating:1265),
				Player.new(first_name:"CAMERON",last_name:"REDDEN",rating:1255),
				Player.new(first_name:"SARAH",last_name:"STARRETT",rating:1244),
				Player.new(first_name:"MARIO",last_name:"GONZALES",rating:1232),
				Player.new(first_name:"MIKE",last_name:"TREPTOW",rating:1219),
				Player.new(first_name:"GEOFF",last_name:"FR. WARD",rating:1205),
				Player.new(first_name:"ETHAN",last_name:"ELSER",rating:1189),
				Player.new(first_name:"TERRY",last_name:"LONGBOW",rating:1171),
				Player.new(first_name:"CLARENCE",last_name:"WORLEY",rating:1150)
			]

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
		return linear
	end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:player1_id,:player2_id,:player3_id,:player4_id,
                                        :team1_set1_games,:team1_set2_games,:team1_set3_games,
                                        :team2_set1_games,:team2_set2_games,:team2_set3_games,
                                        :played_at)
    end
end
