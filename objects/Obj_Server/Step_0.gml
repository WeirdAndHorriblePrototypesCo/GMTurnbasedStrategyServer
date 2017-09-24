/// @description TURN clock


Time = floor(get_timer()/1000000);
if Time-TurnDuration*TurnAmount == 1 {
	TurnAmount+=1
	
	var _Size = 1024;
	var _Type = buffer_fixed;
	var _Alignment = 1;
	BufferOut = buffer_create(_Size,_Type,_Alignment)
	
	buffer_seek(BufferOut, buffer_seek_start, 0);
	buffer_write(BufferOut, buffer_string, "Next Turn");			
		
	var _Rounds = 0
	
	repeat ds_list_size(Sockets) {
		//Network send in a repeat statement to every connected player.
		network_send_packet(ds_list_find_value(Sockets,_Rounds), BufferOut, buffer_tell(BufferOut));
		_Rounds+=1
		}
	
	}