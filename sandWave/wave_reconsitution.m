function output = wave_reconsitution(handles)
global wave_handles_old;
%% 基础设置
handles.hydro_grid_switch_status = wave_handles_old.hydro_grid_switch_status;
handles.coordinate = wave_handles_old.coordinate;
handles.dy = wave_handles_old.dy;
handles.lat_min = wave_handles_old.lat_min;
handles.lat_max = wave_handles_old.lat_max ;
handles.lon_min = wave_handles_old.lon_min;
handles.dx = wave_handles_old.dx;
handles.lon_max = wave_handles_old.lon_max;
handles.water_depth_file_path = wave_handles_old.water_depth_file_path;
handles.generat_mesh_depth_button_status = wave_handles_old.generat_mesh_depth_button_status;
handles.WindSpeed = wave_handles_old.WindSpeed;
handles.WindDir = wave_handles_old.WindDir;
%界面设置
if(isequal(handles.claculation_content_status(2),1))
    handles.hydro_grid_switch_status = 0;
    set(handles.hydro_grid_switch,'Enable','off');
    if(isequal(handles.coordinate,'Cartesian'))
        set(handles.coordinate_select,'Enable','on','Value',1);
    else
        set(handles.coordinate_select,'Enable','on','Value',2);
    end
    if(~isnan(handles.dy))
        set(handles.dy_input,'Enable','on','string',num2str(handles.dy));
    else
        set(handles.dy_input,'Enable','on','string','');
    end
    if(~isnan(handles.lat_min))
        set(handles.lat_min_input,'Enable','on','string',num2str(handles.lat_min));
    else
        set(handles.lat_min_input,'Enable','on','string','');
    end
    if(~isnan(handles.lat_max))
        set(handles.lat_max_input,'Enable','on','string',num2str(handles.lat_max));
    else
        set(handles.lat_max_input,'Enable','on','string','');
    end
    if(~isnan(handles.lon_min))
        set(handles.lon_min_input,'Enable','on','string',num2str(handles.lon_min));
    else
        set(handles.lon_min_input,'Enable','on','string','');
    end
    if(~isnan(handles.dx))
        set(handles.dx_input,'Enable','on','string',num2str(handles.dx));
    else
        set(handles.dx_input,'Enable','on','string','');
    end
    if(~isnan(handles.lon_max))
        set(handles.lon_max_input,'Enable','on','string',num2str(handles.lon_max));
    else
        set(handles.lon_max_input,'Enable','on','string','');
    end
    if(~isempty(handles.water_depth_file_path))
        set(handles.water_depth_file_way_set,'string',handles.water_depth_file_path);
    else
        set(handles.water_depth_file_way_set,'string','');
    end
    set(handles.water_depth_choose_button,'Enable','on')
    if (isequal(handles.generat_mesh_depth_button_status,ones(1,7)))
        set(handles.generat_mesh_depth_button,'Enable','on')
    else
        set(handles.generat_mesh_depth_button,'Enable','off')
    end
else
    set(handles.hydro_grid_switch,'Enable','on');
    if(isequal(handles.hydro_grid_switch_status,0))
        set(handles.hydro_grid_switch,'Value',0);
        if(isequal(handles.coordinate,'Cartesian'))
            set(handles.coordinate_select,'Enable','on','Value',1);
        else
            set(handles.coordinate_select,'Enable','on','Value',2);
        end
        if(~isnan(handles.dy))
            set(handles.dy_input,'Enable','on','string',num2str(handles.dy));
        else
            set(handles.dy_input,'Enable','on','string','');
        end
        if(~isnan(handles.lat_min))
            set(handles.lat_min_input,'Enable','on','string',num2str(handles.lat_min));
        else
            set(handles.lat_min_input,'Enable','on','string','');
        end
        if(~isnan(handles.lat_max))
            set(handles.lat_max_input,'Enable','on','string',num2str(handles.lat_max));
        else
            set(handles.lat_max_input,'Enable','on','string','');
        end
        if(~isnan(handles.lon_min))
            set(handles.lon_min_input,'Enable','on','string',num2str(handles.lon_min));
        else
            set(handles.lon_min_input,'Enable','on','string','');
        end
        if(~isnan(handles.dx))
            set(handles.dx_input,'Enable','on','string',num2str(handles.dx));
        else
            set(handles.dx_input,'Enable','on','string','');
        end
        if(~isnan(handles.lon_max))
            set(handles.lon_max_input,'Enable','on','string',num2str(handles.lon_max));
        else
            set(handles.lon_max_input,'Enable','on','string','');
        end
        if(~isempty(handles.water_depth_file_path))
            set(handles.water_depth_file_way_set,'string',handles.water_depth_file_path);
        else
            set(handles.water_depth_file_way_set,'string','');
        end
        set(handles.water_depth_choose_button,'Enable','on')
        if (isequal(handles.generat_mesh_depth_button_status,ones(1,7)))
            set(handles.generat_mesh_depth_button,'Enable','on')
        else
            set(handles.generat_mesh_depth_button,'Enable','off')
        end
    else
        set(handles.hydro_grid_switch,'Value',1);
        set(handles.coordinate_select,'Enable','off','Value',1);
        set(handles.dy_input,'Enable','off','string','')
        set(handles.lat_min_input,'Enable','off','string','')
        set(handles.lat_max_input,'Enable','off','string','')
        set(handles.lon_min_input,'Enable','off','string','')
        set(handles.dx_input,'Enable','off','string','')
        set(handles.lon_max_input,'Enable','off','string','')
        set(handles.water_depth_choose_button,'Enable','off')
        set(handles.water_depth_file_way_set,'string','');
        set(handles.generat_mesh_depth_button,'Enable','off')
    end
end

if (isequal(handles.WindSpeed,0))
    set(handles.WindSpeed_input,'string','0.0');
else
    set(handles.WindSpeed_input,'string',num2str(handles.WindSpeed));
end
if (isequal(handles.WindDir,0))
    set(handles.WindDir_input,'string','0.0');
else
    set(handles.WindDir_input,'string',num2str(handles.WindDir));
end
%% 边界条件
handles.WaveHeight = wave_handles_old.WaveHeight;
handles.Period = wave_handles_old.Period ;
handles.Direction = wave_handles_old.Direction;
handles.DirSpreading = wave_handles_old.DirSpreading;
handles.type_id = wave_handles_old.type_id;
handles.last_step = wave_handles_old.last_step;
handles.dir = wave_handles_old.dir;
handles.wave_file_generate_button_index = wave_handles_old.wave_file_generate_button_index;
% 界面设置
set(handles.boundary_type_select,'string',handles.dir);  
set(handles.boundary_type_select,'Value',handles.type_id);
if (handles.type_id ~= 1)
    set(handles.WaveHeight_input,'Enable','on');
    set(handles.Period_input,'Enable','on');
    set(handles.Direction_input,'Enable','on');
    set(handles.DirSpreading_input,'Enable','on');
    if (handles.WaveHeight(handles.type_id-1)||handles.Period (handles.type_id-1)||...
            handles.Direction (handles.type_id-1)||handles.DirSpreading (handles.type_id-1) ~= 4)
        set(handles.WaveHeight_input,'string',num2str(handles.WaveHeight(handles.type_id-1)));
        set(handles.Period_input,'string',num2str(handles.Period (handles.type_id-1)));
        set(handles.Direction_input,'string',num2str(handles.Direction (handles.type_id-1)));
        set(handles.DirSpreading_input,'string',num2str(handles.DirSpreading (handles.type_id-1)));
    else
        set(handles.WaveHeight_input,'string','');
        set(handles.Period_input,'string','');
        set(handles.Direction_input,'string','');
        set(handles.DirSpreading_input,'string',num2str(4));
    end
else
    set(handles.WaveHeight_input,'string','','Enable','off');
    set(handles.Period_input,'string','','Enable','off');
    set(handles.Direction_input,'string','','Enable','off');
    set(handles.DirSpreading_input,'string','4','Enable','off');
end
if (isequal(handles.wave_file_generate_button_index,0))
    set(handles.wave_file_generate_button,'Enable','off')
else
    set(handles.wave_file_generate_button,'Enable','on')
end
%% 物理过程
handles.Breaking = wave_handles_old.Breaking;
handles.Triads = wave_handles_old.Triads;
handles.WhiteCapping = wave_handles_old.WhiteCapping;
handles.Refraction = wave_handles_old.Refraction ;
handles.FreqShift = wave_handles_old.FreqShift;
handles.WindGrowth = wave_handles_old.WindGrowth;
handles.BreakAlpha = wave_handles_old.BreakAlpha;
handles.BreakGamma = wave_handles_old.BreakGamma;
handles.TriadsAlpha = wave_handles_old.TriadsAlpha;
handles.TriadsBeta = wave_handles_old.TriadsBeta;
handles.BedFricCoef = wave_handles_old.BedFricCoef;
handles.BedFricCoef_switch_index = wave_handles_old.BedFricCoef_switch_index;
% 设置界面
if(isequal(handles.Breaking,'ture'))
    set(handles.Breaking_switch,'Value',1);
    set(handles.BreakAlpha_input,'string',num2str(handles.BreakAlpha),'Enable','on');
    set(handles.BreakGamma_input,'string',num2str(handles.BreakGamma),'Enable','on');
else
    set(handles.Breaking_switch,'Value',0);
    set(handles.BreakAlpha_input,'string','','Enable','off');
    set(handles.BreakGamma_input,'string','','Enable','off');
end
if(isequal(handles.Triads,'false'))
    set(handles.Triads_switch,'Value',0);
    set(handles.TriadsAlpha_input,'string','','Enable','off');
    set(handles.TriadsBeta_input,'string','','Enable','off');
else
    set(handles.Triads_switch,'Value',1);
    set(handles.TriadsAlpha_input,'string',num2str(handles.TriadsAlpha),'Enable','on');
    set(handles.TriadsBeta_input,'string',num2str(handles.TriadsBeta),'Enable','on');
end
if(isequal(handles.WhiteCapping,'off'))
    set(handles.WhiteCapping_switch,'Value',0);
else
    set(handles.WhiteCapping_switch,'Value',1);
end
if(isequal(handles.WindGrowth,'false'))
    set(handles.WindGrowth_switch,'Value',0)
else
    set(handles.WindGrowth_switch,'Value',1)
end
if(isequal(handles.Refraction,'true'))
    set(handles.Refraction_switch,'Value',1)
else
    set(handles.Refraction_switch,'Value',0)
end
if(isequal(handles.FreqShift,'true'))
    set(handles.FreqShift_switch,'Value',1)
else
    set(handles.FreqShift_switch,'Value',0)
end
if(isequal(handles.BedFricCoef_switch_index,1))
    set(handles.BedFricCoef_switch,'Value',1)
    set(handles.BedFricCoef_input,'string',num2str(handles.BedFricCoef),'Enable','on')
else
    set(handles.BedFricCoef_switch,'Value',0)
    set(handles.BedFricCoef_input,'string','','Enable','off')
end

%%
output = handles;
end

