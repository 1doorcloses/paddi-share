# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


org = Org.new(name:"The Town Club")
org.save!

league = League.new(name:"Men's League")
org.leagues << league

#
linear = [		
	Player.new(first_name:"SCOTT",last_name:"PECOR",phone:"414-737-5866",email:"specor@aol.com",rating:1990),
	Player.new(first_name:"TOM",last_name:"BELL",phone:"414-429-1102",email:"tbell2028@gmail.com",rating:1980),
	Player.new(first_name:"CURT",last_name:"SMITH",phone:"414-332-3942",email:"curt@boulderventure.com",rating:1970),
	Player.new(first_name:"VICTOR",last_name:"V. RECKMEYER",phone:"414-721-6062",email:"vreckmeyer@reckmeyerlaw.com",rating:1960),
	Player.new(first_name:"DAVID",last_name:"PELISEK",phone:"414-573-7222",email:"davepelisek@gmail.com",rating:1950),
	Player.new(first_name:"MARK",last_name:"SHORT",phone:"414-352-7634",email:"mark.short@chase.com",rating:1940),
	Player.new(first_name:"DAVID",last_name:"POLLACK",phone:"720-261-8349",email:"townclubpaddle@gmail.com",rating:1930),
	Player.new(first_name:"JONATHAN",last_name:"CANTWELL",phone:"262-744-0503",email:"jonathan@cantwe11marketing.com",rating:1920),
	Player.new(first_name:"AARON",last_name:"GARDNER",phone:"414-418-7924",email:"gards21@gmail.com",rating:1910),
	Player.new(first_name:"WILL",last_name:"W. STALLE",phone:"414-460-8855",email:"wstalle@kw.com",rating:1900),
	Player.new(first_name:"JEFF",last_name:"FRANK",phone:"414-469-1163",email:"Jfrank@robertsonryan.com",rating:1890),
	Player.new(first_name:"MIKE",last_name:"KELLY",phone:"414-270-3219",email:"mikek@parkbankonline.com",rating:1880),
	Player.new(first_name:"PETER",last_name:"KLUG",phone:"414-248-8935",email:"Ptklug@gmail.com",rating:1870),
	Player.new(first_name:"TREVOR",last_name:"D'SOUZA",phone:"414-745-4751",email:"trevords@aol.com",rating:1860),
	Player.new(first_name:"JOHN",last_name:"WATSON",phone:"480-528-5509",email:"jcwatson3@gmail.com",rating:1850),
	Player.new(first_name:"STEVE",last_name:"SPADAFORA",phone:"414-247-1308",email:"stephen.spadafora@gmail.com",rating:1840),
	Player.new(first_name:"ALEX",last_name:"STARRETT",phone:"414-581-4337",email:"Alex.Starrett@fisglobal.com",rating:1830),
	Player.new(first_name:"BJORN",last_name:"SCHWEINSBERG",phone:"414-897-4856",email:"beyonborg@gmail.com",rating:1820),
	Player.new(first_name:"JON",last_name:"BLOOM",phone:"917-364-5458",email:"jbloom358@yahoo.com",rating:1810),
	Player.new(first_name:"ANDREW",last_name:"A. ROBBINS",phone:"414-732-8227",email:"Andrew.Robbins.1@gmail.com",rating:1800),
	Player.new(first_name:"BILL",last_name:"MAXON",phone:"414-350-1144",email:"bmaxon@maxon.com",rating:1790),
	Player.new(first_name:"DAN",last_name:"D. HALLER",phone:"925-457-6422",email:"haller328@yahoo.com",rating:1780),
	Player.new(first_name:"TUCK",last_name:"T. MAXON",phone:"414-915-5855",email:"tmaxon@maxon.com",rating:1770),
	Player.new(first_name:"STEPHEN",last_name:"S. COX",phone:"630-222-3521",email:"stephencox224@gmail.com",rating:1760),
	Player.new(first_name:"GARD",last_name:"G. PECOR",phone:"414-870-2979",email:"ghgpecor@gmail.com",rating:1750),
	Player.new(first_name:"JOHN",last_name:"J. RECKMEYER",phone:"414-559-0534",email:"jreckmeyer@rwbaird.com",rating:1740),
	Player.new(first_name:"MIKE",last_name:"HAYES",phone:"414-405-5678",email:"attymichaelhayes@gmail.com",rating:1730),
	Player.new(first_name:"TODD",last_name:"MUDERLAK",phone:"414-708-1585",email:"toddmuderlak@gmail.com",rating:1720),
	Player.new(first_name:"MOE",last_name:"DRANE",phone:"608-213-1535",email:"mdrane@growthcatalysts.com",rating:1710),
	Player.new(first_name:"CHARLIE",last_name:"C. STALLE",phone:"414-467-8745",email:"charlie.stalle@gmail.com",rating:1700),
	Player.new(first_name:"EDDIE",last_name:"E. BURKE",phone:"414-331-7576",email:"Ed.paul.burke@gmail.com",rating:1690),
	Player.new(first_name:"MILT",last_name:"FUEHRER",phone:"210-352-0093",email:"m.fuehrer@palermospizza.com",rating:1680),
	Player.new(first_name:"SCOTT",last_name:"GRENIER",phone:"414-765-3953",email:"sgrenier@rwbaird.com",rating:1670),
	Player.new(first_name:"BOB",last_name:"KUESEL",phone:"414-581-4158",email:"rkuesel@sbcglobal.net",rating:1660),
	Player.new(first_name:"ERIC",last_name:"GAENSLEN",phone:"414-587-0919",email:"eric.gaenslen@aurora.org",rating:1650),
	Player.new(first_name:"ROBIN",last_name:"BUCKLEY",phone:"414-333-3049",email:"hot4lax@sbcglobal.net",rating:1640),
	Player.new(first_name:"MITCH",last_name:"M. COX",phone:"630-200-2985",email:"mitchelcox28@gmail.com",rating:1630),
	Player.new(first_name:"KEVIN",last_name:"LAZOVIK",phone:"414-828-5355",email:"kevinlazovik@gmail.com",rating:1620),
	Player.new(first_name:"RICK",last_name:"R. READ",phone:"262-873-0034",email:"rreadmnc@yahoo.com",rating:1610),
	Player.new(first_name:"FREDDIE",last_name:"F. STALLE",phone:"414-839-7133",email:"fstalle@yahoo.com",rating:1600),
	Player.new(first_name:"CHAD",last_name:"LEHMAN",phone:"414-531-2423",email:"chadlehman@gmail.com",rating:1590),
	Player.new(first_name:"QUINN",last_name:"ELLSWORTH",phone:"414-406-3651",email:"qellsworth@jmesales.com",rating:1580),
	Player.new(first_name:"TJ",last_name:"HAUSKE",phone:"414-403-1115",email:"tommyhauske@yahoo.com",rating:1570),
	Player.new(first_name:"PETER",last_name:"P. MOEDE JR.",phone:"414-745-1349",email:"peterjay@centerpointeservice.com",rating:1560),
	Player.new(first_name:"JIM",last_name:"BRUCE",phone:"262-241-5567",email:"jamesfbruce@yahoo.com",rating:1550),
	Player.new(first_name:"KIP",last_name:"RANDALL",phone:"262-365-4041",email:"kip.randall@xerox.com",rating:1540),
	Player.new(first_name:"JAMIE",last_name:"WALTERS",phone:"262-419-8550",email:"jamie.walters1984@outlook.com",rating:1530),
	Player.new(first_name:"PETER",last_name:"P. BRENGEL",phone:"414-333-4789",email:"pbrengel@brengel.com",rating:1520),
	Player.new(first_name:"JON",last_name:"HERING",phone:"414-531-6223",email:"jsh@stotzersales.com",rating:1510),
	Player.new(first_name:"ANDY",last_name:"SCHUTZ",phone:"414-335-8601",email:"aschutz@gdlsk.com",rating:1500),
	Player.new(first_name:"MATT",last_name:"GOETZINGER",phone:"414-379-1504",email:"mgoetzinger@fiduciarymgt.com",rating:1490),
	Player.new(first_name:"ANDY",last_name:"VAP",phone:"406-544-3174",email:"avap@huhot.com",rating:1480),
	Player.new(first_name:"NICK",last_name:"WENNER",phone:"414-350-6524",email:"nickwenner@yahoo.com",rating:1470),
	Player.new(first_name:"CHARLIE",last_name:"ELLSWORTH",phone:"414-202-3355",email:"charlesjohnellsworth@gmail.com",rating:1460),
	Player.new(first_name:"PETER",last_name:"NELSON",phone:"414-213-4604",email:"peter@nelsonrep.com",rating:1450),
	Player.new(first_name:"ROY",last_name:"WAGNER",phone:"414-460-3140",email:"rwagner@vonbriesen.com",rating:1440),
	Player.new(first_name:"MICHAEL",last_name:"SIFUENTES",phone:"414-324-9672",email:"msifuentes@hoffmanyork.com",rating:1430),
	Player.new(first_name:"KEITH",last_name:"BRUETT",phone:"414-218-0719",email:"keith.bruett@quarles.com",rating:1420),
	Player.new(first_name:"DAVE",last_name:"KLENKE",phone:"414-687-1127",email:"dklenke@rwbaird.com",rating:1410),
	Player.new(first_name:"RYAN",last_name:"HEATH",phone:"414-704-7762",email:"reheath@gmail.com",rating:1400),
	Player.new(first_name:"JOHN",last_name:"KRAMP",phone:"414-875-7253",email:"jkramp@reinhartlaw.com",rating:1390),
	Player.new(first_name:"RANDY",last_name:"BORCHARDT",phone:"773-255-4849",email:"randall.borchardt@gmail.com",rating:1380),
	Player.new(first_name:"CHARLIE",last_name:"WRIGHT",phone:"414-526-1868",email:"Charlesfwrightjr@gmail.com",rating:1370),
	Player.new(first_name:"TRIP",last_name:"MOONEY",phone:"262-364-4665",email:"edgar.mooney@mssb.com",rating:1360),
	Player.new(first_name:"TOM",last_name:"BAUSCH",phone:"414-627-8181",email:"tbauschwi@yahoo.com",rating:1350),
	Player.new(first_name:"AMIN",last_name:"AFSARI",phone:"262-385-6554",email:"aminafsari@gmail.com",rating:1340),
	Player.new(first_name:"ANTHONY",last_name:"PECORARO",phone:"414-335-8661",email:"anthony.pecoraro@bmo.com",rating:1330),
	Player.new(first_name:"TOM",last_name:"SYLKE",phone:"414-559-2317",email:"tomsylke@core.com",rating:1320),
	Player.new(first_name:"HOWIE",last_name:"HAAS",phone:"262-443-9995",email:"mrhowardhaas@gmail.com",rating:1310),
	Player.new(first_name:"KYLE",last_name:"TRIMBLE",phone:"414-807-0212",email:"trim475@yahoo.com",rating:1300),
	Player.new(first_name:"JOE",last_name:"MATTERA",phone:"516-818-3521",email:"jmattera@wi.rr.com",rating:1290),
	Player.new(first_name:"JOE",last_name:"OLLA",phone:"414-550-3309",email:"Subfenceguy@att.net",rating:1280),
	Player.new(first_name:"NIC",last_name:"HORSFIELD",phone:"608-234-1744",email:"nmhorsfi@gmail.com",rating:1270),
	Player.new(first_name:"DAVID",last_name:"HERMANNY",phone:"920-988-2927",email:"djhermanny@gmail.com",rating:1260),
	Player.new(first_name:"SAM",last_name:"HALPERN",phone:"414-218-8848",email:"sam@seniormarketsales.com",rating:1250),
	Player.new(first_name:"JONATHAN",last_name:"HAEDT",phone:"565-940-2206",email:"jhaedt@hhsales.net",rating:1240),
	Player.new(first_name:"JOE",last_name:"MOEDE",phone:"414-793-0195",email:"joe@centerpointeservice.com",rating:1230),
	Player.new(first_name:"KEN",last_name:"K. BRENGEL",phone:"414-406-9589",email:"ken@spectruminteriors.biz",rating:1220),
	Player.new(first_name:"PATRICK",last_name:"GOEBEL",phone:"414-232-2023",email:"Patrick.Goebel@quarles.com",rating:1210),
	Player.new(first_name:"MICHAEL",last_name:"SULLIVAN",phone:"414-651-5420",email:"msullivan@rwbaird.com",rating:1200),
	Player.new(first_name:"GRANT",last_name:"BURRALL",phone:"414-403-2838",email:"grantburrall@gmail.com",rating:1190),
	Player.new(first_name:"RICK",last_name:"R. STALLE",phone:"414-397-9734",email:"rstalle@wi.rr.com",rating:1180),
	Player.new(first_name:"TIM",last_name:"T. BURKE",phone:"414-915-7232",email:"tim@burkecandy.com",rating:1170),
	Player.new(first_name:"BOB",last_name:"SHARPE",phone:"414-810-3493",email:"sharpe7@gmail.com",rating:1160),
	Player.new(first_name:"MARTIN",last_name:"VERTACNIK",phone:"414-551-5226",email:"mvertacnik@gmail.com",rating:1150),
	Player.new(first_name:"DOUG",last_name:"ERLACHER",phone:"262-853-1219",email:"douglas.c.erlacher@wellsfargo.com",rating:1140),
	Player.new(first_name:"JOHN",last_name:"BOLGER",phone:"414-405-1660",email:"john@bolgerlegalgroup.com",rating:1130),
	Player.new(first_name:"DENNIS",last_name:"ELY",phone:"917-689-6577",email:"dennis.ely@gmail.com",rating:1120),
	Player.new(first_name:"JACK",last_name:"GONZALES",phone:"414-788-9925",email:"mario.gonzales2@usdog.gov",rating:1110),
	Player.new(first_name:"RICK",last_name:"STRICKROOT",phone:"414-690-9193",email:"rstrickroo@gmail.com",rating:1100),
	Player.new(first_name:"JOHN",last_name:"BURESH",phone:"312-213-5506",email:"jburesh4@yahoo.com",rating:1090),
	Player.new(first_name:"BRINT",last_name:"B. ROBBINS",phone:"262-488-7200",email:"brintondr@aol.com",rating:1080),
	Player.new(first_name:"ERIK",last_name:"ALMEIDA",phone:"515-554-4387",email:"erikalmeida77@hotmail.com",rating:1070),
	Player.new(first_name:"JERRY",last_name:"HANSON",phone:"414-732-6301",email:"j_erome@sbcglobal.net",rating:1060),
	Player.new(first_name:"TOM",last_name:"BENEDICT",phone:"414-801-9522",email:"millvalleytom@aol.com",rating:1050),
	Player.new(first_name:"MARIO",last_name:"GONZALES",phone:"414-788-9925",email:"mario.gonzales2@usdog.gov",rating:1040),
	Player.new(first_name:"JORDAN",last_name:"CURNES",phone:"214-770-0935",email:"jordancurnes@gmail.com",rating:1030),
	Player.new(first_name:"BOB",last_name:"RANDALL",phone:"414-530-6350",email:"bob@randata.com",rating:1020),
	Player.new(first_name:"GEOFF",last_name:"FR. WARD",phone:"214-616-4006",email:"fr.geoff@yahoo.com",rating:1010)
]

linear.each do |p|
	p.save!
	league.players << p
end