var _Rounds = 0
repeat ds_list_size(Sockets) {
	//Network send in a repeat statement to every connected player.
	network_send_packet(ds_list_find_value(Sockets,_Rounds), BufferOut, buffer_tell(BufferOut));
	_Rounds+=1
	}