function output = per_process_reconsitution(handles)
global per_process_handles_old ;
%% 水平网格参数
handles.coordinate = per_process_handles_old.coordinate ;
handles.y_dis = per_process_handles_old.y_dis;
handles.y_more_switch_index = per_process_handles_old.y_more_switch_index;
handles.y_more = per_process_handles_old.y_more;
handles.lat_min = per_process_handles_old.lat_min;
handles.lat_more_min = per_process_handles_old.lat_more_min;
handles.lat_more_max = per_process_handles_old.lat_more_max;
handles.lat_max = per_process_handles_old.lat_max;
handles.x_dis = per_process_handles_old.x_dis;
handles.x_more_switch_index = per_process_handles_old.x_more_switch_index;
handles.x_more = per_process_handles_old.x_more;
handles.lon_min = per_process_handles_old.lon_min;
handles.lon_more_min = per_process_handles_old.lon_more_min;
handles.lon_more_max = per_process_handles_old.lon_more_max;
handles.lon_max = per_process_handles_old.lon_max;
handles.x_grid = per_process_handles_old.x_grid;
handles.y_grid = per_process_handles_old.y_grid;
handles.x_axis_1 = per_process_handles_old.x_axis_1;
handles.y_axis_1 = per_process_handles_old.y_axis_1;
handles.x_axis_2 = per_process_handles_old.x_axis_2;
handles.y_axis_2 = per_process_handles_old.y_axis_2;
handles.obs_value = per_process_handles_old.obs_value;
handles.obs_num = per_process_handles_old.obs_num;
handles.obs_id = per_process_handles_old.obs_id;
handles.grid_input_info = per_process_handles_old.grid_input_info;
handles.grid_generate_info = per_process_handles_old.grid_generate_info;
handles.creat_grid_button_switch = per_process_handles_old.creat_grid_button_switch;
handles.write_result = per_process_handles_old.write_result;
handles.water_to_grid = per_process_handles_old.water_to_grid;
handles.per_process_state = per_process_handles_old.per_process_state;
handles.obs_open = per_process_handles_old.obs_open;
% 水平网格界面
if (isequal(handles.coordinate,'Spherical'))
    set(handles.coordinate_select,'Value',1);
else
    set(handles.coordinate_select,'Value',2);
end
if (isnan(handles.y_dis))
    set(handles.y_dis_input,'string','');
else
    set(handles.y_dis_input,'string',num2str(handles.y_dis));
end
if(isequal(handles.y_more_switch_index,0))
    set(handles.y_more_switch,'Value',0);
    set(handles.y_more_input,'string','1','Enable','off');
    set(handles.lat_more_min_input,'string','','Enable','off');
    set(handles.lat_more_max_input,'string','','Enable','off');
else
    set(handles.y_more_switch,'Value',1);
    set(handles.y_more_input,'string',num2str(handles.y_more),'Enable','on');
    if(isnan(handles.lat_more_min))
        set(handles.lat_more_min_input,'string','','Enable','on');
    else
        set(handles.lat_more_min_input,'string',num2str(handles.lat_more_min),'Enable','on');
    end
    if(isnan(handles.lat_more_max))
        set(handles.lat_more_max_input,'string','','Enable','on');
    else
        set(handles.lat_more_max_input,'string',num2str(handles.lat_more_max),'Enable','on');
    end
end
if (isnan(handles.lat_min))
    set(handles.lat_min_input,'string','');
else
    set(handles.lat_min_input,'string',num2str(handles.lat_min));
end
if (isnan(handles.lat_max))
    set(handles.lat_max_input,'string','');
else
    set(handles.lat_max_input,'string',num2str(handles.lat_max));
end
if (isnan(handles.x_dis))
    set(handles.x_dis_input,'string','');
else
    set(handles.x_dis_input,'string',num2str(handles.x_dis));
end
if (isequal(handles.y_more_switch_index,0))
    set(handles.x_more_switch,'Value',0);
    set(handles.x_more_input,'string','1','Enable','off');
    set(handles.lon_more_min_input,'string','','Enable','off');
    set(handles.lon_more_max_input,'string','','Enable','off');
else
    set(handles.x_more_switch,'Value',1);
    set(handles.x_more_input,'string',num2str(handles.x_more),'Enable','on');
    if (isnan(handles.lon_more_min))
        set(handles.lon_more_min_input,'string','','Enable','on');
    else
        set(handles.lon_more_min_input,'string',num2str(handles.lon_more_min),'Enable','on');
    end
    if (isnan(handles.lon_more_max))
            set(handles.lon_more_max_input,'string','','Enable','on');
    else
        set(handles.lon_more_max_input,'string',num2str(handles.lon_more_max),'Enable','on');
    end
end
if (isnan(handles.lon_min))
    set(handles.lon_min_input,'string','');
else
    set(handles.lon_min_input,'string',num2str(handles.lon_min));
end
if (isnan(handles.lon_min))
    set(handles.lon_max_input,'string','');
else
    set(handles.lon_max_input,'string',num2str(handles.lon_max));
end

if (isequal(handles.creat_grid_button_switch,ones(1,6)))
    set(handles.creat_grid_button,'Enable','on')
else
    set(handles.creat_grid_button,'Enable','off')
end
if (~isempty(handles.obs_value) && ~isempty(handles.obs_id)) 
    set(handles.obs_button,'Enable','on');
else
    set(handles.obs_button,'Enable','off');
end
%画图
if(~isequal(handles.per_process_state(1),0))
    plot(handles.grid_axes,handles.y_axis_2,handles.x_axis_2,'k',handles.y_axis_1,handles.x_axis_1,'k');
    axes(handles.grid_axes);
    set(gca,'FontSize',7)
    xlabel('经度（°）','FontSize',7);
    ylabel('纬度（°）','FontSize',7);
else
    axes(handles.grid_axes);
    set(gca,'XColor',[1 1 1])
    set(gca,'YColor',[1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
end
%% 垂向分层
handles.layer = per_process_handles_old.layer;
handles.layer_s = per_process_handles_old.layer_s;
handles.layer_b = per_process_handles_old.layer_b;
handles.layer_show = per_process_handles_old.layer_show;
%设置界面
if(isequal(handles.layer,0))
    set(handles.layered_generate_button,'Enable','off');
    set(handles.layer_input,'string','');
else
    set(handles.layered_generate_button,'Enable','on');
    set(handles.layer_input,'string',num2str(handles.layer));
end
if(isequal(handles.layer_s,0))
    set(handles.layer_s_switch,'Value',0);
    set(handles.layer_s_input,'Enable','off','string','0');
else
    set(handles.layer_s_switch,'Value',1);    
    set(handles.layer_s_input,'Enable','on','string',num2str(handles.layer_s));   
end
if(isequal(handles.layer_b,0))
    set(handles.layer_b_switch,'Value',0);
    set(handles.layer_b_input,'Enable','off','string','0');
else
    set(handles.layer_b_switch,'Value',1);
    set(handles.layer_b_input,'Enable','on','string',num2str(handles.layer_b));
end
%画图
if (~isempty(handles.layer_show))
    x = 0:0.1:10;
    axes(handles.layer_axes);
    cla;
    for i = 1:handles.layer+1
        y1 = 6*sin(2*pi/20*x)-10;
        y2 = handles.layer_show(i,1)*y1/100;
        plot(x*100,y2*3,'-r');
        hold on
    end
    set(gca,'FontSize',7)
    xlabel('距离（m）','FontSize',7);
    ylabel('水深（m）','FontSize',7);
else
    axes(handles.layer_axes);cla;
    set(gca,'XColor',[1 1 1])
    set(gca,'YColor',[1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
end
%% 水深
handles.choose_database_switch_index = per_process_handles_old.choose_database_switch_index;
handles.choose_water_depth_switch_index = per_process_handles_old.choose_water_depth_switch_index;
handles.database_file_path = per_process_handles_old.database_file_path;
handles.water_depth_file_path = per_process_handles_old.water_depth_file_path;
handles.Z = per_process_handles_old.Z;
handles.dep_east = per_process_handles_old.dep_east;
handles.dep_west = per_process_handles_old.dep_west;
handles.dep_south = per_process_handles_old.dep_south;
handles.dep_north = per_process_handles_old.dep_north;
%设置水深界面
if(isequal(handles.choose_database_switch_index,0))
    set(handles.choose_database_switch,'Value',0);
    set(handles.choose_database_button,'Enable','off');
    set(handles.database_path_set,'string','');
else
    set(handles.choose_database_switch,'Value',1);
    set(handles.choose_database_button,'Enable','on');
    if(~isempty(handles.database_file_path))
        set(handles.database_path_set,'string',handles.database_file_path);
        set(handles.create_wate_depth_button,'Enable','on');
    end
end
if(isequal(handles.choose_water_depth_switch_index,0))
    set(handles.choose_water_depth_switch,'Value',0);
    set(handles.choose_water_depth_file_button,'Enable','off');
    set(handles.water_depth_file_path_set,'string','');
else
    set(handles.choose_water_depth_switch,'Value',1);
    set(handles.choose_water_depth_file_button,'Enable','on');
    if(~isempty(handles.water_depth_file_path))
        set(handles.water_depth_file_path_set,'string',handles.water_depth_file_path);
        set(handles.create_wate_depth_button,'Enable','on');
    end
end
if(isempty(handles.water_depth_file_path)&&isempty(handles.database_file_path))
    set(handles.create_wate_depth_button,'Enable','off');
end
% 画图
if(~isempty(handles.Z))
    Z_plot = handles.Z(1:end-1,1:end-1);
    pcolor(handles.depth_axes,handles.y_axis_2,handles.x_axis_2,Z_plot);
    axes(handles.depth_axes);
    set(gca,'FontSize',7)
    xlabel('经度（°）','FontSize',7);
    ylabel('纬度（°）','FontSize',7);
    shading interp;   % 显示
    colorbar;
else
    axes(handles.depth_axes);cla;
    set(gca,'XColor',[1 1 1])
    set(gca,'YColor',[1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    colorbar off;
end
%% 边界
handles.bund_all = per_process_handles_old.bund_all;
handles.bund_all_id = per_process_handles_old.bund_all_id;
handles.opne_bnd_num = per_process_handles_old.opne_bnd_num;
handles.comp_all = per_process_handles_old.comp_all;
handles.comp_all_index = per_process_handles_old.comp_all_index;
handles.comp_now =  per_process_handles_old.comp_now;
handles.comp_button_status = per_process_handles_old.comp_button_status;
%设置边界界面
if(~isequal(handles.claculation_content_status(5),1))
    set(handles.bund_east_select,'Value',handles.bund_all_id(1))
    set(handles.bund_west_select,'Value',handles.bund_all_id(2))
    set(handles.bund_south_select,'Value',handles.bund_all_id(3))
    set(handles.bund_north_select,'Value',handles.bund_all_id(4))
    set(handles.two_N2_select,'Value',handles.comp_all_index(1));
    set(handles.clean_init_boundary_button,'Enable','on');
    for i = 2:22
        eval(['set(handles.',handles.comp_all{i},'_select',',','''Value''',',handles.comp_all_index(i))'])
    end
    if(isequal(handles.comp_button_status(1),1))
        set(handles.comp_all_select_button,'Enable','on');
    else
        set(handles.comp_all_select_button,'Enable','off');
    end
    if(isequal(handles.comp_button_status(2),1))
        set(handles.comp_clean_select_button,'Enable','on');
    else
        set(handles.comp_clean_select_button,'Enable','off');
    end
    if(isequal(handles.comp_button_status(3),1))
        set(handles.comp_finish_button,'Enable','on');
    else
        set(handles.comp_finish_button,'Enable','off');
    end
else
    set(handles.bund_east_select,'Enable','off');
    set(handles.bund_west_select,'Enable','off');
    set(handles.bund_south_select,'Enable','off');
    set(handles.bund_north_select,'Enable','off');
    set(handles.comp_all_select_button,'Enable','off');
    set(handles.comp_clean_select_button,'Enable','off');
    set(handles.comp_finish_button,'Enable','off');
    set(handles.clean_init_boundary_button,'Enable','off');
end
%% 输出 
output = handles;
end


