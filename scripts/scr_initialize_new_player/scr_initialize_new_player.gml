var _Size = 1024;
var _Type = buffer_fixed;
var _Alignment = 1;
BufferOut = buffer_create(_Size,_Type,_Alignment)

buffer_seek(BufferOut, buffer_seek_start, 0);
buffer_write(BufferOut, buffer_string, "Wind Direction");
buffer_write(BufferOut, buffer_u32, WindDirection);
buffer_write(BufferOut, buffer_u32, WindSpeed);

network_send_packet(ds_list_size(Sockets), BufferOut, buffer_tell(BufferOut));