/// @description Create Network

Startup = 1
Version = "Version 2.1"

//TCP more reliable than UDP (It checks packages) & is made for connections. 
//UDP broadcasts, making it a little faster. (Can be used for getting IP adresses, looking for servers etc)
var _Type = network_socket_tcp;

//Obvious port is obvious. 
//Please make sure the port makes some sort of sense.
var _Port = 8000; 

//More players?
MaxClients = 5; 
Server = network_create_server(_Type,_Port,MaxClients)
if Server < 0
    {
    //Connection error!
	Startup = 2
    }
//The thing that makes the connection between the server & the client.
Sockets = ds_list_create()
TakenUsernames = ds_list_create()

////////////////////////////////////////////////////////////////////////////////////////////////
//Turn info. // Settings.
Time = 0
TurnDuration = 120
TurnAmount = 0

/////////////////////////////////////////////////////////////////////////////////////////////////
CloudDirection=irandom(360)
CloudSpeed = irandom(3)+irandom(2)
CloudStrength = random(1)

////////////////////////////////////////////////////////////////////////////////////////////////
Command = ds_list_create()

////////////////////////////////////////////////////////////////////////////////////////////////
 ///VARIABLES for world generation.
//Set the grid sizes. If you change it here, you change it everywhere.
global.GridWidth		= 64; //size of every square
global.GridHeight		= 64;
global.GridDepth        = 64;
global.WorldSeed		= "Fire water burn";
global.WorldWidth		= 512;
global.WorldHeight		= 512;
global.WorldArray		= array_world_create(global.GridWidth,global.GridHeight,global.GridDepth);
//Setting the world seed
random_set_seed(global.WorldSeed);

