function output = per_process_water_depth_generate(handles)
    if (get(handles.choose_database_switch,'Value'))
        lon_lim = [handles.lon_min handles.lon_max];
        lat_lim = [handles.lat_min handles.lat_max];
        [topo,~] = etopo(handles.database_file_path, 1, lat_lim, lon_lim);
        topo=-1*topo;
        topo(topo<0)=-999;
        
        [m_1,n_1] = size(topo);
        dx_1 = (handles.lat_max-handles.lat_min)/(m_1-1);
        dy_1 = (handles.lon_max-handles.lon_min)/(n_1-1);
        % 生成经纬度的列表
        lat = handles.lat_min:dx_1:handles.lat_max;
        lon = handles.lon_min:dy_1:handles.lon_max;
        % 生成与网格匹配的水深数据。
        mm=m_1*n_1;
        depth=zeros(mm,3);
        k=0;
        for i=1:m_1
            for j=1:n_1
                depth(j+k,3)=topo(i,j);
                depth(j+k,2)=lat(1,i);
                depth(j+k,1)=lon(1,j);
            end
            k=k+n_1;
        end
        
        if (~get(handles.choose_water_depth_switch,'Value'))
            Z = griddata(depth(:,1),depth(:,2),depth(:,3),handles.y_axis_2,handles.x_axis_2);
        else
            water_depth_data = load(handles.water_depth_file_path);
            x_meas = water_depth_data(:,1);
            y_meas = water_depth_data(:,2);
            z_meas = water_depth_data(:,3);
            % 获取需要进行插值的范围
            x_meas_min = min(min(x_meas));
            x_meas_max = max(max(x_meas));
            [~,indx_min] = find(handles.y_axis_2(1,:)<=x_meas_min);
            index_min_x = indx_min(1,end);
            [~,indx_max] = find(handles.y_axis_2(1,:)>=x_meas_max);
            index_max_x = indx_max(1,1);
            
            y_meas_min = min(min(y_meas));
            y_meas_max = max(max(y_meas));
            [indy_min,~] = find(handles.x_axis_2(:,1)<=y_meas_min);
            index_min_y = indy_min(end,1);
            [indy_max,~] = find(handles.x_axis_2(:,1)>=y_meas_max);
            index_max_y = indy_max(1,1);
            % 取X，Y
            X_meas = handles.y_axis_2(index_min_y:index_max_y,index_min_x:index_max_x);
            Y_meas = handles.x_axis_2(index_min_y:index_max_y,index_min_x:index_max_x);
            grid_meas1 = griddata(x_meas,y_meas,z_meas,X_meas,Y_meas);
            Z = griddata(depth(:,1),depth(:,2),depth(:,3),handles.y_axis_2,handles.x_axis_2);
            Z(index_min_y:index_max_y,index_min_x:index_max_x) = grid_meas1;
        end
    elseif (~get(handles.choose_database_switch,'Value') && get(handles.choose_water_depth_switch,'Value'))
        water_depth_data = load(handles.water_depth_file_path);
        x_meas = water_depth_data(:,1);
        y_meas = water_depth_data(:,2);
        z_meas = water_depth_data(:,3);
        Z = griddata(x_meas,y_meas,z_meas,handles.y_axis_2,handles.x_axis_2);
    end
    [~,row]=size(handles.y_grid);
    [~,column]=size(handles.x_grid);
    Z = [Z,-999*ones(row,1)];
    Z = [Z;-999*ones(1,column+1)];
    output = Z;
end

