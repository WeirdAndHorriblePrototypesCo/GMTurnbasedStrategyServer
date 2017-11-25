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
buffer_write(ResourceBuffer, buffer_u32, ini_read_real(_Username,"Planks",0))
buffer_write(ResourceBuffer, buffer_u32, ini_read_real(_Username,"Food",0))
buffer_write(ResourceBuffer, buffer_u32, ini_read_real(_Username,"Stone",0))
buffer_write(ResourceBuffer, buffer_u32, ini_read_real(_Username,"Workers",0))
network_send_packet(ds_list_size(Sockets), ResourceBuffer, buffer_tell(ResourceBuffer));