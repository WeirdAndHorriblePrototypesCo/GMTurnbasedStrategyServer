//array_world_set(input data,target array,x location, y location, z location);
var input_data = argument[0],
	map_array = argument[1],
	x1 = argument[2],
    y1 = argument[3],
    z1 = argument[4];
	
// map keys are stored as a string for ease of use. This converts exact layer numbers into that string.	
if !is_string(z1){
	z1 = ds_list_find_value(global.LayerTypes, z1);
}

var in_array = map_array[? z1];
in_array[@ x1,y1]= input_data;

