function output = observation_point_reconsitution(handles)
global observation_point_handle_old;
handles.obs_id = observation_point_handle_old.obs_id ;
handles.obs_value = observation_point_handle_old.obs_value;
handles.x_grid = observation_point_handle_old.x_grid;
handles.y_grid = observation_point_handle_old.y_grid;
handles.obs_row_name = observation_point_handle_old.obs_row_name;
handles.now_row_id = observation_point_handle_old.now_row_id;
handles.output = observation_point_handle_old.output;

set(handles.obs_table,'data',handles.obs_value);
set(handles.obs_table,'RowName',handles.obs_row_name);


output = handles;
end

