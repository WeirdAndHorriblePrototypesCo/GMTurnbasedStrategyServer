/// @description Console commands
var _Skip = 0
if keyboard_lastkey == 9 {
	_Skip = 1
	}
if keyboard_lastkey == 160 || keyboard_lastkey == 161 || keyboard_lastkey == 13 {
    _Skip = 1;
    }
if keyboard_lastkey == 8 && _Skip == 0 {
	ds_list_delete(Command,ds_list_size(Command)-1)
	exit
	}
if _Skip == 0 {
    ds_list_add(Command,keyboard_lastchar)
    }

var _Rounds = 0
var _CommandText = ""
var _Skip = 0
if keyboard_lastkey == 13 {
    //Get the string you have typed.
	repeat ds_list_size(Command) {
		_CommandText+=string(ds_list_find_value(Command,_Rounds))
		_Rounds+=1
		}
    
    _Rounds=0
    var _StringStart = 0
    var _StringEnd = 0
    var _AmountOfStrings = 1
    var _String1 = ""
    var _String2 = ""
    var _String3 = ""
    var _String4 = ""
    var _String5 = ""
    repeat string_length(_CommandText) {
        if string_byte_at(_CommandText,_Rounds) == 32 {
            if _AmountOfStrings == 1 { _String1 = string_copy(_CommandText,_StringStart-1,_StringEnd-1) }
            if _AmountOfStrings == 2 { _String2 = string_copy(_CommandText,_StringStart,_StringEnd) }
            if _AmountOfStrings == 3 { _String3 = string_copy(_CommandText,_StringStart,_StringEnd) }
            if _AmountOfStrings == 4 { _String4 = string_copy(_CommandText,_StringStart,_StringEnd) }
            if _AmountOfStrings == 5 { _String5 = string_copy(_CommandText,_StringStart,_StringEnd) }
            _AmountOfStrings+=1
            _StringStart = _Rounds+1
            _StringEnd =-1
            }
        if string_length(_CommandText) == _Rounds+1 {
            if _AmountOfStrings == 1 { _String1 = string_copy(_CommandText,_StringStart-1,_StringEnd+1) }
            if _AmountOfStrings == 2 { _String2 = string_copy(_CommandText,_StringStart,_StringEnd+2) }
            if _AmountOfStrings == 3 { _String3 = string_copy(_CommandText,_StringStart,_StringEnd+2) }
            if _AmountOfStrings == 4 { _String4 = string_copy(_CommandText,_StringStart,_StringEnd+2) }
            if _AmountOfStrings == 5 { _String5 = string_copy(_CommandText,_StringStart,_StringEnd+2) }
            }
        _StringEnd+=1
        _Rounds+=1
        }
    //Check if it is a command.
    if _String1 == "AddName" || _String1 == "AllowUser" || _String1 == "AddUser" {
        _Rounds = 0
        repeat ds_list_size(TakenUsernames) {
            if ds_list_find_value(TakenUsernames,_Rounds) == _String2 {
                ds_list_delete(TakenUsernames,_Rounds)
                break;
                }
            _Rounds+=1
            }
        }
    
    if _String1 == "AddPlanks" {
        var _Target = _String2
        var _Amount = _String3
        var _NewAmount = ini_read_real(_Target,"Planks",0)+real(_Amount)
        buffer_seek(BufferOut, buffer_seek_start, 0);
        buffer_write(BufferOut, buffer_string, "Cheat, Give Planks")
	    buffer_write(BufferOut, buffer_string, _Target);		
		buffer_write(BufferOut, buffer_u32, _Amount);
        ini_write_real(_Target,"Planks",_NewAmount)
        scr_send_everyone()
        }
    if _String1 == "AddFood" {
        var _Target = _String2
        var _Amount = _String3
        var _NewAmount = ini_read_real(_Target,"Food",0)+real(_Amount)
        buffer_seek(BufferOut, buffer_seek_start, 0);
        buffer_write(BufferOut, buffer_string, "Cheat, Give Food")
	    buffer_write(BufferOut, buffer_string, _Target);		
		buffer_write(BufferOut, buffer_u32, _Amount);
        ini_write_real(_Target,"Food",_NewAmount)
        scr_send_everyone()
        }
    if _String1 == "AddStone" {
        var _Target = _String2
        var _Amount = _String3
        var _NewAmount = ini_read_real(_Target,"Stone",0)+real(_Amount)
        buffer_seek(BufferOut, buffer_seek_start, 0);
        buffer_write(BufferOut, buffer_string, "Cheat, Give Stone")
	    buffer_write(BufferOut, buffer_string, _Target);		
		buffer_write(BufferOut, buffer_u32, _Amount);
        ini_write_real(_Target,"Stone",_NewAmount)
        scr_send_everyone()
        }
    if _String1 == "AddWorkers" {
        var _Target = _String2
        var _Amount = _String3
        var _NewAmount = ini_read_real(_Target,"Workers",0)+real(_Amount)
        buffer_seek(BufferOut, buffer_seek_start, 0);
        buffer_write(BufferOut, buffer_string, "Cheat, Give Workers")
	    buffer_write(BufferOut, buffer_string, _Target);		
		buffer_write(BufferOut, buffer_u32, _Amount);
        ini_write_real(_Target,"Workers",_NewAmount)
        scr_send_everyone()
        }
    //Whoops, this thing breaks all statistics.
    if _String1 == "TurnDuration" || _String1 == "Timer" {
        TurnDuration = real(_String2)
        TurnAmount=floor(((Time-TurnDuration*TurnAmount)-TurnDuration)/3)
        }
    ds_list_clear(Command)
    }