/// @discription Received packet(Buffer)

//Get a ref to buffer
//You'll get 1,100,120 here.
var _Buffer = argument[0];

//To indentify what type of data we have just received.
//When you read from a buffer, you remove that part from it.
//From here on the info in the buffer will be 100,120.
var _MessageId = buffer_read(_Buffer,buffer_u8);

switch(_MessageId) {
	case 1:
		var _Mx = buffer_read(_Buffer, buffer_u32); //120
		var _My = buffer_read(_Buffer, buffer_u32); //Nothing left in the buffer.
		instance_create_depth(_Mx, _My, 0, Obj_Click)
		break;
	case 2:
		TargetPlayer = buffer_read(_Buffer,buffer_u8);
		break;
	}