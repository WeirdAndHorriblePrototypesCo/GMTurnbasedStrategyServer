var x1 = argument[0],
    y1 = argument[1],
    z1 = argument[2];

//Getting all the layer types from a .ini file. Allowing for expansion later on.
global.LayerTypes = ds_list_create();
ini_open(working_directory+"WorldLayers.txt");
var _Rounds = 0;
var _String = "";
_String=string("N")+string(_Rounds);
repeat 1000 {
	ds_list_add(global.LayerTypes,ini_read_string("LayerTypes",_String,"Error!"));
	_Rounds+=1;
	_String=string("N")+string(_Rounds);
	if !ini_key_exists("LayerTypes",_String) {
		break;
		}
	}
ini_close();
//Filling the map, which holds the layer types, with 2d arrays. These arrays hold all the data.
var map_array = ds_map_create();
var inner_array;
var _X = 0;
var _Y = 0;
var _Z = 0;

repeat(z1){
	repeat(x1){
		repeat(y1){
			inner_array[_X,_Y] = irandom_range(1,63); // Fill array with random values
			_Y+=1
			}

		_Y=0;
		_X+=1;
		}
    ds_map_add(map_array,ds_list_find_value(global.LayerTypes,_Z), inner_array);
    if ds_list_find_value(global.LayerTypes,_Z) == "" {
	    break;
        }
	_X=0;
    _Y=0;
	_Z+=1;
}
_Z=0;

return map_array;


