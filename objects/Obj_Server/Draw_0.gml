/// @description Draw data
draw_text(10,10,string("The server is currently running...") );
if Startup = 1 { draw_text(10,25,"Bind to port succesful") }
if Startup = 2 { draw_text_color(10,25,"Bind to port FAILED!!!",c_red,c_red,c_red,c_red,1) }
draw_text(10,40,string("Connected Players = ") + string(ds_list_size(Sockets)))
draw_text(10,55,string("Max players = ") + string(MaxClients))
draw_text(10,70,string("Time until next turn = ") + string(floor(TurnDuration*TurnAmount-Time+1)))
draw_text(10,85,string("Amount of Turns passed = ") + string(TurnAmount))
draw_text(10,100,string("Cloud Speed = ") + string(CloudSpeed))
draw_text(10,115,string("Cloud Direction = ") + string(CloudDirection))
draw_text(10,130,string("Cloud Strength = ") + string(CloudStrength))


//The connected player data.
var _Rounds = 0

repeat ds_list_size(Sockets) {
	draw_text(700,10+_Rounds*15,string("Player ")+string(_Rounds+1)+string(" = ")+string(ds_list_find_value(Sockets,_Rounds)))
	_Rounds+=1
	}
if _Rounds = MaxClients { draw_text_colour(700,10+_Rounds*15+15,"The server is full!!!",c_red,c_red,c_red,c_red,1) }