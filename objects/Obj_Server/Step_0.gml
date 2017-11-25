 /// @description TURN clock


Time = floor(get_timer()/1000000);
if TurnDuration*TurnAmount-Time+1 < 0 {
	TurnAmount+=1
	}
if Time-TurnDuration*TurnAmount == 1 {
	TurnAmount+=1
	//This section is for the TURN. \/\/\/
	//Set required variables for creating a buffer & create one.
	var _Size = 1024;
	var _Type = buffer_fixed;
	var _Alignment = 1;
	BufferOut = buffer_create(_Size,_Type,_Alignment)
	
	//Fill the buffer.
	buffer_seek(BufferOut, buffer_seek_start, 0);
	buffer_write(BufferOut, buffer_string, "Next Turn");			
	
	//Send the buffer.
	var _Rounds = 0
	repeat ds_list_size(Sockets) {
		//Network send in a repeat statement to every connected player.
		network_send_packet(ds_list_find_value(Sockets,_Rounds), BufferOut, buffer_tell(BufferOut));
		_Rounds+=1
		}
		
	
	//This section is for the wind direction \/\/\/\/
	if irandom(15) == 15 {

		CloudDirection=irandom(360)
		CloudSpeed = 1
		if irandom(8)  == 8  {CloudSpeed=0}
		if irandom(5)  == 5  {CloudSpeed=2}
		if irandom(15) == 15 {CloudSpeed=5}
		CloudStrength = irandom(3)+irandom(2)+irandom(1)+irandom(1)+irandom(1)+irandom(2)
		
		BufferOut = buffer_create(_Size,_Type,_Alignment)
	
		buffer_seek(BufferOut, buffer_seek_start, 0);
		buffer_write(BufferOut, buffer_string, "Wind Direction");
		buffer_write(BufferOut, buffer_u16, CloudDirection);
		buffer_write(BufferOut, buffer_u8, CloudSpeed);
		buffer_write(BufferOut, buffer_u8, CloudStrength);
		
		var _Rounds = 0
	
		repeat ds_list_size(Sockets) {
			network_send_packet(ds_list_find_value(Sockets,_Rounds), BufferOut, buffer_tell(BufferOut));
			_Rounds+=1
			}
		}
	
	}
    
ini_open(working_directory + "UserDetails.txt")