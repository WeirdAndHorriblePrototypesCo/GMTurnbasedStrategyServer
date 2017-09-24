/// @discription Received packet(Buffer)

//Get a ref to buffer
//You'll get 1,100,120 here.

//Im not sure what this argument does here. But it makes things work.
//If there is issues with multiple buffers, look here. This is most likely the cause.
var _Buffer = argument[0];

//To indentify what type of data we have just received.
//When you read from a buffer, you remove that part from it.
//From here on the info in the buffer will be 100,120.
var _MessageId = buffer_read(_Buffer,buffer_string);


switch(_MessageId) {

	case "Click":		//This case puts a dot on the screen.
		var _Mx = buffer_read(_Buffer, buffer_u32); //120
		var _My = buffer_read(_Buffer, buffer_u32); //Nothing left in the buffer.
		instance_create_depth(_Mx, _My, 0, Obj_Click)
		break;
		
	case "House":		//This case sends the data received to all players.
		var _Size = 1024;
		var _Type = buffer_fixed;
		var _Alignment = 1;
		BufferOut = buffer_create(_Size,_Type,_Alignment)
		
		buffer_seek(BufferOut, buffer_seek_start, 0);
		buffer_write(BufferOut, buffer_string, "House");			
		buffer_write(BufferOut, buffer_u32, buffer_read(_Buffer, buffer_u32));	
		buffer_write(BufferOut, buffer_u32, buffer_read(_Buffer, buffer_u32));
		
		var _Rounds = 0
		
		repeat ds_list_size(Sockets) {
			//Network send in a repeat statement to every connected player.
			network_send_packet(ds_list_find_value(Sockets,_Rounds), BufferOut, buffer_tell(BufferOut));
			_Rounds+=1
			}
		break;
		
	
	}