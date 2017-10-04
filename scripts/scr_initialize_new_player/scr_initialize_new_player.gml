//Send all the data to the new players!
var _Size = 1024;
var _Type = buffer_fixed;
var _Alignment = 1;
var _Buffer = argument[0]
var _Username = buffer_read(_Buffer,buffer_string)

//CloudBuffer
CloudBuffer = buffer_create(_Size,_Type,_Alignment)
buffer_seek(CloudBuffer, buffer_seek_start, 0);
buffer_write(CloudBuffer, buffer_string, "Wind Direction");
buffer_write(CloudBuffer, buffer_u16, CloudDirection);
buffer_write(CloudBuffer, buffer_u8, CloudSpeed);
buffer_write(CloudBuffer, buffer_u8, CloudStrength);
network_send_packet(ds_list_size(Sockets), CloudBuffer, buffer_tell(CloudBuffer));

ResourceBuffer = buffer_create(_Size,_Type,_Alignment)
buffer_seek(ResourceBuffer, buffer_seek_start, 0)
buffer_write(ResourceBuffer, buffer_string, "Login Resources")
buffer_write(ResourceBuffer, buffer_u16, ini_read_real(_Username,"Planks",0))
buffer_write(ResourceBuffer, buffer_u16, ini_read_real(_Username,"Food",0))
buffer_write(ResourceBuffer, buffer_u16, ini_read_real(_Username,"Stone",0))
buffer_write(ResourceBuffer, buffer_u16, ini_read_real(_Username,"Workers",0))
network_send_packet(ds_list_size(Sockets), ResourceBuffer, buffer_tell(ResourceBuffer));
//Send the MAP to the player.
exit
MapBuffer = buffer_create(_Size,_Type,_Alignment)
var _RoundsX = 0
var _RoundsY = 0
var _RoundsZ = 1
var _String  = ""
var _MapSize = 32

repeat global.GridZ {
	repeat global.GridX {
		buffer_seek(MapBuffer, buffer_seek_start, 0);
		buffer_write(MapBuffer, buffer_string,"Layer")
		buffer_write(MapBuffer, buffer_u8,_RoundsX)
		buffer_write(MapBuffer, buffer_u8,_RoundsZ)
		repeat global.GridY {
	
			buffer_resize(MapBuffer,_MapSize)
			_Mapsize+=8
		
//			buffer_write(MapBuffer, buffer_u8, array_3d_get(global.WorldArray,_RoundsX,_RoundsY,_RoundsZ);
			_RoundsY+=1
		
			}
		network_send_packet(ds_list_size(Sockets), MapBuffer, buffer_tell(MapBuffer)); //Gonna send it to the wrong person here. (The latest connect, not the newest player)
		_RoundsX+=1
		_RoundsY=0
		}
	_RoundsX=0
	_RoundsY=0
	_RoundsZ+=1
	}
//buffer_write(MapBuffer, buffer_u8, );
network_send_packet(ds_list_size(Sockets), MapBuffer, buffer_tell(MapBuffer));