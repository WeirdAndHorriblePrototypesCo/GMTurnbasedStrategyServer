/// @description Destroy the server

//To make sure you do not end up having the server online when it should not be.
network_destroy(Server)
if buffer_exists(BufferOut) { buffer_delete(BufferOut); }
ini_close()