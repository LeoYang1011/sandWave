function output = wave_update_dir(dir_id,dir_list,handles)
if (dir_id ~= 1 && (handles.WaveHeight(dir_id-1) ~= 0||handles.Period(dir_id-1) ~= 0||...
    handles.Direction(dir_id-1) ~= 0||handles.DirSpreading(dir_id-1) ~= 4) && dir_list{dir_id}(end) ~= '+')
    dir_list{dir_id} = [dir_list{dir_id},'+'];
elseif(dir_id ~= 1 && (handles.WaveHeight(dir_id-1) == 0 && handles.Period(dir_id-1) == 0 &&...
    handles.Direction(dir_id-1) == 0 && handles.DirSpreading(dir_id-1) == 4) && dir_list{dir_id}(end) == '+')
    dir_list{dir_id} = dir_list{dir_id}(1:end-1);
end
output = dir_list;
end

