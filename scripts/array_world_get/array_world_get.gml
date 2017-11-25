//array_world_get(target array,x location, y location, z location);
var out_array = argument[0],
	x1 = argument[1],
    y1 = argument[2],
    z1 = argument[3];

// map keys are stored as a string for ease of use. This converts exact layer numbers into that string.	
if !is_string(z1){
	z1 = ds_list_find_value(global.LayerTypes, z1);
}

var in_array = out_array[? z1];
return in_array[x1,y1];

