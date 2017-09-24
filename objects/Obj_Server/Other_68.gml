/// @description Clients & Data

//Network types
//Connect -> when you connect to the server.
//disconnect -> when the client disconnects
//data -> when the server gets data

//The async gets prefilled -> I'm getting the type from it (If it has it).
var _TypeEvent = async_load[? "type"];

//If you are connecting (TypeEvent == network_type_connect)
switch(_TypeEvent) {


	case network_type_connect:
		//List data structure to have all the sockets for multiple clients.
		//Add the client to the socket variable (Should be a list)
		if ds_list_size(Sockets) < MaxClients {
			//If there is a client trying to connect, get the socket of the connection.
			var _Target = ds_map_find_value(async_load, "socket");
			ds_list_add(Sockets,_Target);
			
			//Send all info to the player that it needs to have to initialize.
			script_execute(scr_initialize_new_player);
			}
		else { show_message("Too many players!") }
		break;
			
			
			
	case network_type_disconnect:
		//If you disconnect. Remove the socket.
		var _Target = ds_map_find_value(async_load, "socket");
		ds_list_delete(Sockets,ds_list_find_index(Sockets,_Target)); 
		//Get the number from the _Target (the socket "number") & then remove that from the list (Taking that number as a position)
		//How and why this works, I dont recall, but it works. Dont complain, go outside, you dont go outside enough. I swear it.
		break;
		
		
		
	case network_type_data:
		//When the client sends us data.
		
		//handle the data.
		//Buffers are like variables. They are variables that can be send though the "tunnel" (socket).
		//The value will be put into the buffer.
		//Buffers are always read from the start.
		var Buffer = async_load[? "buffer"];
		//Get the start of the buffer.
		buffer_seek(Buffer, buffer_seek_start, 0);
		//Get the script
		scr_received_packet(Buffer);
		break;
		
		
	} 