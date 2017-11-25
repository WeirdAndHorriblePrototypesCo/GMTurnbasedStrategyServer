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

var _Size = 1024;
var _Type = buffer_fixed;
var _Alignment = 1;
BufferOut = buffer_create(_Size,_Type,_Alignment)

switch(_MessageId) {
    case "House":
        buffer_write(BufferOut, buffer_string, "House");
        buffer_write(BufferOut, buffer_u32, buffer_read(_Buffer, buffer_u32));	
		buffer_write(BufferOut, buffer_u32, buffer_read(_Buffer, buffer_u32));
        buffer_write(BufferOut, buffer_string, buffer_read(_Buffer, buffer_string));
        scr_send_everyone()
        break;
	case "Small Building":		//This case sends the data received to all players.
		buffer_seek(BufferOut, buffer_seek_start, 0);
        buffer_write(BufferOut,buffer_string,"Small Building") //command | package code
        var _Type = buffer_read(_Buffer,buffer_string) //type
        var _LayerNumber = buffer_read(_Buffer, buffer_u32) //Layer number
        var _XLoc = buffer_read(_Buffer, buffer_u32)
        var _YLoc = buffer_read(_Buffer, buffer_u32)
        var _Username = buffer_read(_Buffer, buffer_string)
		buffer_write(BufferOut, buffer_u32, _XLoc);	//x
		buffer_write(BufferOut, buffer_u32, _YLoc);  //y
        buffer_write(BufferOut, buffer_string, _Username); //username
        buffer_write(BufferOut, buffer_string, _Type);
        buffer_write(BufferOut, buffer_u32, _LayerNumber)
        scr_send_everyone()
        array_world_set(_LayerNumber, global.WorldArray, _XLoc, _YLoc, 3)
        array_world_set(_Username, global.WorldArray, _XLoc, _YLoc, 4)
		break;
	case "Login":
		var _Username = buffer_read(_Buffer,buffer_string)
		var _Password = buffer_read(_Buffer,buffer_string)
		var _Rounds = 0
		
		//Load from txt file.
		repeat ds_list_size(TakenUsernames) {
			if ds_list_find_value(TakenUsernames,_Rounds) == _Username {
				buffer_seek(BufferOut, buffer_seek_start, 0);
				buffer_write(BufferOut, buffer_string, "User already login")
				scr_send_everyone()
				exit
				}
			_Rounds+=1
			}
		if ini_read_string(_Username,"Password","Error") != _Password {
			buffer_seek(BufferOut, buffer_seek_start, 0);
			buffer_write(BufferOut, buffer_string, "Error");		
			buffer_write(BufferOut, buffer_string, "Wrong username or password!");
			}
		else {
			buffer_seek(BufferOut, buffer_seek_start, 0);
			buffer_write(BufferOut, buffer_string, "Login Success");
            buffer_write(BufferOut, buffer_string, _Username)
            buffer_write(BufferOut, buffer_string, _Password)
			ds_list_add(TakenUsernames,_Username)
			}
		
		//Network send in a repeat statement to every connected player.
		//For socket; see receiving data.
		scr_send_everyone()
		break;
	case "Logout":
		var _Username = buffer_read(_Buffer,buffer_string)
		ini_write_real(_Username,"Planks",buffer_read(_Buffer,buffer_u32))
		ini_write_real(_Username,"Food",buffer_read(_Buffer,buffer_u32))
		ini_write_real(_Username,"Stone",buffer_read(_Buffer,buffer_u32))
		ini_write_real(_Username,"Workers",buffer_read(_Buffer,buffer_u32))
		ds_list_delete(TakenUsernames,ds_list_find_index(TakenUsernames,_Username))
		break;
	case "New Player":
		//Send all info to the player that it needs to have to initialize.
		script_execute(scr_initialize_new_player,_Buffer);
		break;
    case "Terrain Map":
        //Monster inbound. Send terrain to the client.
        TerrainBuffer = buffer_create(_Size,buffer_grow,_Alignment)
        buffer_seek(TerrainBuffer, buffer_seek_start, 0)
        buffer_write(TerrainBuffer, buffer_string, "Terrain Map")
        buffer_write(TerrainBuffer, buffer_string, buffer_read(_Buffer, buffer_string))
        buffer_write(TerrainBuffer, buffer_u32, global.GridWidth)
        buffer_write(TerrainBuffer, buffer_u32, global.GridHeight)
        buffer_write(TerrainBuffer, buffer_u32, global.GridDepth)
        buffer_write(TerrainBuffer, buffer_u32, global.WorldHeight)
        buffer_write(TerrainBuffer, buffer_u32, global.WorldWidth)
        var _X = 0
        var _Y = 0
        var _Z = 0
        var _Target = 0
        repeat global.GridDepth {
            repeat global.GridHeight {
                repeat global.GridWidth {
                    _Target = array_world_get(global.WorldArray,_X,_Y,_Z)
                    buffer_write(TerrainBuffer, buffer_u32, _Target);
                    _X+=1
                    }
                _Y+=1
                _X=0
                }
            _Z+=1
            _Y=0
            _X=0
            }
        var _Rounds = 0
        repeat ds_list_size(Sockets) {
        	//Network send in a repeat statement to every connected player.
        	network_send_packet(ds_list_find_value(Sockets,_Rounds), TerrainBuffer, buffer_tell(TerrainBuffer));
        	_Rounds+=1
        	}
        buffer_delete(TerrainBuffer)
        show_debug_message("Send all tiles to the player logging in!")
        break;
	case "Create Account":
		var _Username = buffer_read(_Buffer,buffer_string)
		var _Password = buffer_read(_Buffer,buffer_string)
		//Save to txt file 
		//PLEASE READ ME: The file can be found in /LOCAL in your app-data. 
		//Its under Turn_Based_Strategy_Server in a seperate folder for some reason!!!!!
        //When you create a new account, you cannot see it in UserDetails yet! It will only 
        //show once you have closed down the server.
        if ini_section_exists(_Username) {
            buffer_seek(BufferOut,buffer_seek_start,0)
            buffer_write(BufferOut,buffer_string,"Username Taken")
            buffer_write(BufferOut,buffer_string,_Username)
            scr_send_everyone()
            exit
            }
		ini_write_string(_Username,"Password",_Password)
		ini_write_real(_Username,"Planks",15)
		ini_write_real(_Username,"Food",30)
		ini_write_real(_Username,"Workers",5)
		ini_write_real(_Username,"Stone",15)
		break;
	case "Turn Resources":
		var _Username = buffer_read(_Buffer, buffer_string)
		ini_write_real(_Username,"Planks", ini_read_real(_Username,"Planks",0)+buffer_read(_Buffer, buffer_u32))
		ini_write_real(_Username,"Food", ini_read_real(_Username,"Food",0)+buffer_read(_Buffer, buffer_u32))
        ini_write_real(_Username,"Stone", ini_read_real(_Username,"Stone",0)+buffer_read(_Buffer, buffer_u32))
        ini_write_real(_Username,"Workers", ini_read_real(_Username,"Workers",0)+buffer_read(_Buffer, buffer_u32))
        buffer_seek(BufferOut,buffer_seek_start,0)
        buffer_write(BufferOut,buffer_string,"Resources Gained")
        buffer_write(BufferOut,buffer_string,_Username)
        buffer_write(BufferOut,buffer_u32,ini_read_real(_Username,"Planks",0))
        buffer_write(BufferOut,buffer_u32,ini_read_real(_Username,"Food",0))
        buffer_write(BufferOut,buffer_u32,ini_read_real(_Username,"Stone",0))
        buffer_write(BufferOut,buffer_u32,ini_read_real(_Username,"Workers",0))
        scr_send_everyone()
		break;
		//Send recourses back.
    case "Buy Building":
        var _Username = buffer_read(_Buffer, buffer_string)
        ini_write_real(_Username, "Planks", buffer_read(_Buffer, buffer_u32))
        ini_write_real(_Username, "Food", buffer_read(_Buffer, buffer_u32))
        ini_write_real(_Username, "Stone", buffer_read(_Buffer, buffer_u32))
        ini_write_real(_Username, "Workers", buffer_read(_Buffer, buffer_u32))
        break;
	}