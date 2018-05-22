function varargout = post(varargin)
% POST MATLAB code for post.fig
%      POST, by itself, creates a new POST or raises the existing
%      singleton*.
%
%      H = POST returns the handle to a new POST or the handle to
%      the existing singleton*.
%
%      POST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POST.M with the given input arguments.
%
%      POST('Property','Value',...) creates a new POST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before post_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to post_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help post

% Last Modified by GUIDE v2.5 18-May-2018 10:25:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @post_OpeningFcn, ...
                   'gui_OutputFcn',  @post_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before post is made visible.
function post_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to post (see VARARGIN)

% Choose default command line output for post
handles.output = hObject;
%变量初始化
if(~isempty(varargin{2}))
    handles.workpath = varargin{2};
else
    handles.workpath = pwd;
end
handles.parameter_all_ch = {'       请选择参数';};
handles.parameter_all_en = {'nothing'};
handles.FileInfo_wave = {};
handles.data_wave = {};
handles.FileInfo_his = {};
handles.data_his = {};
handles.FileInfo_map = {};
handles.data_map = {};
handles.xmin = {1,1};
handles.ymin = {1,1};
handles.xmax = {'',''};
handles.ymax = {'',''};
handles.zmin = {1};
handles.zmax = {''};
handles.stepmin = {1,1,1};
handles.stepmax = {'','',''};
handles.times = {'',''};
handles.xlim = {[],[]};
handles.ylim = {[],[]};
handles.zlim = {[]};
handles.steplim = {[],[],[]};
handles.sta_name = {};
handles.x_scale = 1;
handles.y_scale = 1;
handles.z_scale = 1;
handles.D3 = 0;
handles.parameter_id = 1;
handles.data_id = 1;
handles.current_step = 1;
handles.current_layer = 1;
%界面初始化
set(handles.data_select,'Value',1);
handles = post_reset_plotSetting(handles);
% Update handles structure
guidata(hObject, handles);
uiwait(handles.figure1);

% UIWAIT makes post wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = post_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1)


% --- Executes on selection change in data_select.
function data_select_Callback(hObject, eventdata, handles)
% hObject    handle to data_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns data_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data_select
handles.data_id = get(hObject,'Value');
if(isequal(handles.data_id,2))
    if(~exist([handles.workpath,'\trim-1.dat'],'file'))
        set(handles.data_select,'Value',1);
        handles.data_id = 1;
        handles.parameter_all_ch = {'       请选择参数'};
        handles.parameter_all_en = {'nothing'};
        handles = post_reset_plotSetting(handles);
        uiwait(msgbox('不存在水动力海床数据，请重新选择','错误','error'));
        return
    else
        handles.parameter_all_ch = {'       请选择参数';'             水位';'             水深';...
            '             流速';'         平均流速';'         床面高程';'         冲淤变化'};
        handles.parameter_all_en = {'nothing','water level','water depth','velocity','depth averaged velocity',...
            'bed level in water level points','cum. erosion/sedimentation'};
        handles = post_reset_plotSetting(handles);
        handles.x_scale = 1;
        handles.y_scale = 1;
        handles.z_scale = 1;
        handles.D3 = 0;
        handles.parameter_id = 1;
        handles.current_step = 1;
        handles.current_layer = 1;
        set(handles.time_obs_change,'string','当前时间：')
        if(isempty(handles.data_map))
            filename = [handles.workpath,'\trim-1.dat'];
            handles.FileInfo_map = qpfopen(filename);
            handles.data_map = qpread(handles.FileInfo_map);
        end
    end
    
elseif(isequal(handles.data_id,3))
    if(~exist([handles.workpath,'\trih-1.dat'],'file'))
        set(handles.data_select,'Value',1);
        handles.data_id = 1;
        handles.parameter_all_ch = {'       请选择参数'};
        handles.parameter_all_en = {'nothing'};
        handles = post_reset_plotSetting(handles);
        uiwait(msgbox('不存在站点数据，请重新选择','错误','error'));
        return
    else
        handles.parameter_all_ch = {'       请选择参数';'             水位';'         平均流速';...
            '         床面高程'};
        handles.parameter_all_en = {'nothing','water level','depth averaged velocity',...
            'bed level'};
        handles = post_reset_plotSetting(handles);
        handles.x_scale = 1;
        handles.y_scale = 1;
        handles.z_scale = 1;
        handles.D3 = 0;
        handles.parameter_id = 1;
        handles.current_step = 1;
        handles.current_layer = 1;
        set(handles.time_obs_change,'string','监测点号：')
        if(isempty(handles.data_his))
            filename = [handles.workpath,'\trih-1.dat'];
            handles.FileInfo_his = qpfopen(filename);
            handles.data_his = qpread(handles.FileInfo_his);
        end
    end
elseif(isequal(handles.data_id,4))
    if(~exist([handles.workpath,'\wavm-1.dat'],'file'))
        set(handles.data_select,'Value',1);
        handles.data_id = 1;
        handles.parameter_all_ch = {'       请选择参数'};
        handles.parameter_all_en = {'nothing'};
        handles = post_reset_plotSetting(handles);
        uiwait(msgbox('不存在波浪数据，请重新选择','错误','error'));
        return
    else
        handles.parameter_all_ch = {'       请选择参数';'             水深';'             风速';'             波向';...
            '         有效波高';'         平均周期';'         平均波长';'       近底轨道速度'};
        handles.parameter_all_en = {'nothing','water depth', 'wind velocity', 'hsig wave vector (mean direction)',...
            'hsig wave height','mean wave period T_{m01}','mean wave length', 'orbital velocity near bottom'};
        handles = post_reset_plotSetting(handles);
        handles.x_scale = 1;
        handles.y_scale = 1;
        handles.z_scale = 1;
        handles.D3 = 0;
        handles.parameter_id = 1;
        handles.current_step = 1;
        handles.current_layer = 1;
        set(handles.time_obs_change,'string','当前时间：')
        if(isempty(handles.data_wave))
            filename = [handles.workpath,'\wavm-1.dat'];
            handles.FileInfo_wave = qpfopen(filename);
            handles.data_wave = qpread(handles.FileInfo_wave);
        end
    end
else
    handles.parameter_all_ch = {'       请选择参数'};
    handles.parameter_all_en = {'nothing'};
    handles = post_reset_plotSetting( handles );
end
guidata(hObject, handles);
    

% --- Executes during object creation, after setting all properties.
function data_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in parameter_select.
function parameter_select_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns parameter_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameter_select
handles.parameter_id = get(hObject,'Value');
if(~isequal(handles.parameter_id,1))
    if(isequal(handles.data_id,2))
        if(ismember(handles.parameter_id,[2,3,6,7]))
            handles.unit = 'm';
        else
            handles.unit = 'm/s';
        end  
        if(isempty(handles.zmax{1})||(isequal(handles.parameter_id,4)&&isequal(handles.zmax{1},0)))
            data_analysis = strcmp({handles.data_map.Name},handles.parameter_all_en{handles.parameter_id});
            [~,n] = find(data_analysis==1);
            size1 = qpread(handles.FileInfo_map,handles.data_map(n),'size');
            handles.zmax{1} = size1(1,5);
            if(isempty(handles.stepmax{1})||isempty(handles.xmax{1})||isempty(handles.ymax{1}))
                handles.stepmax{1} = size1(1,1);
                handles.xmax{1} = size1(1,3);
                handles.ymax{1} = size1(1,4);
                handles.times{1} = qpread(handles.FileInfo_map,handles.data_map(n),'times');
                if(isequal(handles.stepmax{1},0))
                    handles.stepmin{1} = 0;
                end
                if(isequal(handles.xmax{1},0))
                    handles.xmin{1} = 0;
                end
                if(isequal(handles.ymax{1},0))
                    handles.ymin{1} = 0;
                end

                handles.xlim{1} = [handles.xmin{1},handles.xmax{1}];
                handles.ylim{1} = [handles.ymin{1},handles.ymax{1}];

                handles.steplim{1} = [handles.stepmin{1},handles.stepmax{1}];
            end
            if(isequal(handles.zmax{1},0))
                handles.zmin{1} = 0;
            end
            handles.zlim{1} = [handles.zmin{1},handles.zmax{1}];
        end
        set(handles.stepmin_input,'Enable','on','string',num2str(handles.stepmin{1}));
        set(handles.stepmax_input,'Enable','on','string',num2str(handles.stepmax{1}));
        set(handles.xmin_input,'Enable','on','string',num2str(handles.xmin{1}));
        set(handles.xmax_input,'Enable','on','string',num2str(handles.xmax{1}));
        set(handles.ymin_input,'Enable','on','string',num2str(handles.ymin{1}));
        set(handles.ymax_input,'Enable','on','string',num2str(handles.ymax{1}));
        set(handles.x_scale_switch,'Enable','on','Value',0);
        set(handles.x_scale_input,'Enable','off','string','1');
        set(handles.y_scale_switch,'Enable','on','Value',0);
        set(handles.y_scale_input,'Enable','off','string','1');
        set(handles.z_scale_switch,'Enable','on','Value',0);
        set(handles.z_scale_input,'Enable','off','string','1');
        set(handles.gene_fig_button,'Enable','on');
        if(isequal(handles.parameter_id,4))
            set(handles.zmin_input,'Enable','on','string',num2str(handles.zmin{1}));
            set(handles.zmax_input,'Enable','on','string',num2str(handles.zmax{1}));
        else
            set(handles.zmin_input,'Enable','off','string','');
            set(handles.zmax_input,'Enable','off','string','');
        end
        if(isequal(handles.parameter_id,6))
            set(handles.z_scale_switch,'string','Z轴缩放因子\3D绘图：')
        else
            set(handles.z_scale_switch,'string','矢量缩放因子：')
        end
    elseif(isequal(handles.data_id,3))
        if(ismember(handles.parameter_id,[2,4]))
            handles.unit = 'm';
        elseif(isequal(handles.parameter_id,3))
            handles.unit = 'm/s';
        else
            handles.unit = 'kg/m^3';
        end
        if(isempty(handles.stepmax{2}))
            data_analysis = strcmp({handles.data_his.Name},handles.parameter_all_en{handles.parameter_id});
            [~,n] = find(data_analysis==1);
            size1 = qpread(handles.FileInfo_his,handles.data_his(n),'size');
            handles.sta_name = qpread(handles.FileInfo_his,handles.data_his(n),'stations');
            handles.stepmax{2} = size1(1,1);
            if(isequal(handles.stepmax{2},0))
                handles.stepmin{2} = 0;
            end
            handles.steplim{2} = [handles.stepmin{2},handles.stepmax{2}];
        end
        set(handles.stepmin_input,'Enable','on','string',num2str(handles.stepmin{2}));
        set(handles.stepmax_input,'Enable','on','string',num2str(handles.stepmax{2}));
        set(handles.xmin_input,'Enable','off');
        set(handles.xmax_input,'Enable','off');
        set(handles.ymin_input,'Enable','off');
        set(handles.ymax_input,'Enable','off');
        set(handles.x_scale_switch,'Enable','on','Value',0);
        set(handles.y_scale_switch,'Enable','on','Value',0);
        set(handles.zmin_input,'Enable','off');
        set(handles.zmax_input,'Enable','off');
        set(handles.z_scale_switch,'Enable','off','Value',0);  
        set(handles.gene_fig_button,'Enable','on');
    elseif(isequal(handles.data_id,4))
        if(ismember(handles.parameter_id,[2,5,7]))
            handles.unit = 'm';
        elseif(ismember(handles.parameter_id,[3,8]))
            handles.unit = 'm/s';
        else
            handles.unit = 's';
        end
        if(isempty(handles.stepmax{3})||isempty(handles.xmax{2})||isempty(handles.ymax{2}))
            data_analysis = strcmp({handles.data_wave.Name},handles.parameter_all_en{handles.parameter_id});
            [~,n] = find(data_analysis==1);
            size1 = qpread(handles.FileInfo_wave,handles.data_wave(n),'size');
            handles.stepmax{3} = size1(1,1);
            handles.xmax{2} = size1(1,3);
            handles.ymax{2} = size1(1,4);
            handles.times{2} = qpread(handles.FileInfo_wave,handles.data_wave(n),'times');
            if(isequal(handles.stepmax{3},0))
                handles.stepmin{3} = 0;
            end
            if(isequal(handles.xmax{2},0))
                handles.xmin{2} = 0;
            end
            if(isequal(handles.ymax{2},0))
                handles.ymin{2} = 0;
            end
            handles.xlim{2} = [handles.xmin{2},handles.xmax{2}];
            handles.ylim{2} = [handles.ymin{2},handles.ymax{2}];
            handles.steplim{3} = [handles.stepmin{3},handles.stepmax{3}];
        end
        set(handles.stepmin_input,'Enable','on','string',num2str(handles.stepmin{3}));
        set(handles.stepmax_input,'Enable','on','string',num2str(handles.stepmax{3}));
        set(handles.xmin_input,'Enable','on','string',num2str(handles.xmin{2}));
        set(handles.xmax_input,'Enable','on','string',num2str(handles.xmax{2}));
        set(handles.ymin_input,'Enable','on','string',num2str(handles.ymin{2}));
        set(handles.ymax_input,'Enable','on','string',num2str(handles.ymax{2}));
        set(handles.x_scale_switch,'Enable','on','Value',0);
        set(handles.y_scale_switch,'Enable','on','Value',0);
        set(handles.zmin_input,'Enable','off');
        set(handles.zmax_input,'Enable','off');
        set(handles.z_scale_switch,'Enable','off','Value',0);
        set(handles.gene_fig_button,'Enable','on');
    end
else
    handles = post_reset_plotSetting(handles);
end
guidata(hObject, handles);
            
            

% --- Executes during object creation, after setting all properties.
function parameter_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameter_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gene_fig_button.
function gene_fig_button_Callback(hObject, eventdata, handles)
% hObject    handle to gene_fig_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isequal(handles.data_id,2))
    i = handles.current_step;
    data_analysis = strcmp({handles.data_map.Name},handles.parameter_all_en{handles.parameter_id});
    [~,n] = find(data_analysis==1);
    S0 = qpread(handles.FileInfo_map,handles.data_map(n),'griddata',i);
    time1 = handles.times{1}(i,1);
    time2 = datestr(time1,'yyyy-mm-dd HH:MM:SS');
    if isfield(S0,'Val')
        val = S0.Val(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        x_com = S0.X(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        y_com = S0.Y(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        if  handles.D3 == 0
            pcolor(handles.plot_axes,x_com,y_com,val);
        elseif isequal(handles.parameter_id,6) && handles.D3 == 1
            surf(handles.plot_axes,x_com,y_com,val);
        end
        axes(handles.plot_axes)
        shading flat; colorbar;
        set(gca,'da',[handles.x_scale,handles.y_scale,handles.z_scale]);
        title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')','  ',time2]);
        xlabel('x轴（经度）');
        ylabel('y轴（纬度）');
        zlabel('z轴（m）');
        % 结构体写入文件中
%         data.X = x_com;
%         data.Y = y_com;
%         data.Val(:,:,i-handles.stepmin{1}+1) = val(:,:);
%         data.Time{i-handles.stepmin{1}+1} = time2;
%         save([handles.workpath,'\',strtrim(handles.parameter_all_ch{handles.parameter_id}),'.dat'],'data');   
    elseif isfield(S0,'ZComp')
        x_com1 = S0.X(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        y_com1 = S0.Y(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        z_com1 = S0.Z(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        val_x1 = S0.XComp(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        val_y1 = S0.YComp(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        val_z1 = S0.ZComp(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1},handles.zmin{1}:handles.zmax{1});
        [mm,nn,kk] = size(val_x1);
        if mm==1
            z_com = permute(z_com1,[2,3,1]);
            y_com = permute(y_com1,[2,3,1]);
            val_x = permute(val_x1,[2,3,1]);
            val_y = permute(val_y1,[2,3,1]);
            val_z = permute(val_z1,[2,3,1]);
            val = sqrt(val_y.^2+val_z.^2);
            pcolor(handles.plot_axes,y_com,z_com,val);
            axes(handles.plot_axes)
            shading flat;colorbar;
            set(gca,'da',[handles.x_scale,handles.y_scale,1]);
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')','  ',time2]);
            xlabel('x轴（纬度）');
            ylabel('y轴（高度）');
            hold on
            quiver(handles.plot_axes,y_com,z_com,val_y,val_z,'color','r','autoscalefactor',handles.z_scale,'maxHeadSize',handles.z_scale);       
        elseif nn == 1
            x_com = permute(x_com1,[1,3,2]);
            z_com = permute(z_com1,[1,3,2]);
            val_x = permute(val_x1,[1,3,2]);
            val_y = permute(val_y1,[1,3,2]);
            val_z = permute(val_z1,[1,3,2]);
            val = sqrt(val_x.^2+val_z.^2);
            pcolor(handles.plot_axes,x_com,z_com,val);
            axes(handles.plot_axes)
            shading flat;colorbar;
            set(gca,'da',[handles.x_scale,handles.y_scale,1]);
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')','  ',time2]);
            xlabel('x轴（经度）');
            ylabel('y轴（高度）');
        elseif kk == 1
            x_com = permute(x_com1,[2,1,3]);
            y_com = permute(y_com1,[2,1,3]);
            val_x = permute(val_x1,[2,1,3]);
            val_y = permute(val_y1,[2,1,3]);
            val = sqrt(val_x.^2+val_y.^2);
            pcolor(handles.plot_axes,x_com,y_com,val);
            axes(handles.plot_axes)
            shading flat;colorbar;
            set(gca,'da',[handles.x_scale,handles.y_scale,1]);
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')','  ',time2]);
            xlabel('x轴（经度）');
            ylabel('y轴（纬度）');
            hold on
            quiver(handles.plot_axes,x_com,y_com,val_x,val_y,'color','r','autoScaleFactor',handles.z_scale,'MaxHeadSize',handles.z_scale);
            hold off;   
        end
    else
        x_com = S0.X(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        y_com = S0.Y(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        val_x = S0.XComp(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        val_y = S0.YComp(handles.xmin{1}:handles.xmax{1},handles.ymin{1}:handles.ymax{1});
        val = (val_x.^2+val_y.^2).^0.5;
        pcolor(handles.plot_axes,x_com,y_com,val);
        axes(handles.plot_axes)
        shading flat;colorbar;
        set(gca,'da',[handles.x_scale,handles.y_scale,1]);
        hold on;
        quiver(handles.plot_axes,x_com,y_com,val_x,val_y,'color','r','AutoScaleFactor',handles.z_scale,'maxheadsize',handles.z_scale);
%         set(gca,'da',[1,1,1]);
        title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')','  ',time2]);
        xlabel('x轴（经度）');
        ylabel('y轴（纬度）');
        hold off;
    end
elseif(isequal(handles.data_id,3))
    m = handles.current_step;
    data_analysis = strcmp({handles.data_his.Name},handles.parameter_all_en{handles.parameter_id});
    [~,n] = find(data_analysis==1);
    data = qpread(handles.FileInfo_his,handles.data_his(n),'data',handles.stepmin{2}:handles.stepmax{2},m);
    time = data.Time;
    time1 = datestr(time,'mm-dd HH:MM');
    % time2 = str2cell(time1);
    if isfield(data,'XComp')
        x_com = data.XComp;
        y_com = data.YComp;
        Val = sqrt(x_com.^2+y_com.^2);
    else
        Val = data.Val;
    end
    plot(handles.plot_axes,time,Val);
    axes(handles.plot_axes)
    set(gca,'XTicklabel',time1);
    set(gca,'PlotBoxAspectRatio',[handles.x_scale,handles.y_scale,1]);
    title([handles.sta_name{m},':',strtrim(handles.parameter_all_ch{handles.parameter_id})]);
    xlabel('时间');
    ylabel([strtrim(handles.parameter_all_ch{handles.parameter_id}),'/',handles.unit]);
elseif(isequal(handles.data_id,4))
    i = handles.current_step;
    data_analysis = strcmp({handles.data_wave.Name},handles.parameter_all_en{handles.parameter_id});
    [~,n] = find(data_analysis==1);
    data = qpread(handles.FileInfo_wave,handles.data_wave(n),'griddata',i,handles.xmin{2}:handles.xmax{2},handles.ymin{2}:handles.ymax{2});
    x_com = data.X;
    y_com = data.Y;
    time1 = handles.times{2}(i,1);
    time2 = datestr(time1,'yyyy-mm-dd HH:MM:SS');
    if isfield(data,'XComp')
        val_x = data.XComp;
        val_y = data.YComp;
        Val = sqrt(val_x.^2+val_y.^2);
        quiver(handles.plot_axes,x_com,y_com,val_x,val_y,'autoscalefactor',0.5,'maxheadsize',0.5);
        axes(handles.plot_axes)
        xlabel('x（经度）');
        ylabel('y（纬度）');
        title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')  ',time2]);
        set(gca,'da',[1,1,1]);
    else
        if handles.xmin{2} ~= handles.xmax{2} && handles.ymin{2} ~= handles.ymax{2}
            Val = data.Val;
            pcolor(handles.plot_axes,x_com,y_com,Val);
            axes(handles.plot_axes)
            shading interp;colorbar;
            set(gca,'da',[1,1,1]);
            xlabel('x（经度）');
            ylabel('y（纬度）');
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')  ',time2]);
        elseif handles.xmin{2} == handles.xmax{2} && handles.ymin{2} ~= handles.ymax{2}
            Val = data.Val;
            plot(handles.plot_axes,y_com,Val,'-k');
            axes(handles.plot_axes)
            xlabel('y（纬度）');
            ylabel(strtrim(handles.parameter_all_ch{handles.parameter_id}));
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')  ',time2]);         
        elseif handles.xmin{2} ~= handles.xmax{2} && handles.ymin{2} == handles.ymax{2}
            Val = data.Val;
            plot(handles.plot_axes,x_com,Val,'-k');
            xlabel('x（经度）');
            ylabel(strtrim(handles.parameter_all_ch{handles.parameter_id}));
            title([strtrim(handles.parameter_all_ch{handles.parameter_id}),'(',handles.unit,')  ',time2]);         
        end
    end
end
if(isequal(handles.data_id,2))
    slider_step = [1.0/(handles.stepmax{1}-handles.stepmin{1}),1.0/(handles.stepmax{1}-handles.stepmin{1})];
    set(handles.change_time_slider,'Enable','on','max',handles.stepmax{1},'min',handles.stepmin{1},'Value',handles.current_step,'sliderstep',slider_step);
    set(handles.new_time_set_input,'Enable','on','string',num2str(handles.current_step));
elseif(isequal(handles.data_id,4))
    slider_step = [1.0/(handles.stepmax{3}-handles.stepmin{3}),1.0/(handles.stepmax{3}-handles.stepmin{3})];
    set(handles.change_time_slider,'Enable','on','max',handles.stepmax{3},'min',handles.stepmin{3},'Value',handles.current_step,'sliderstep',slider_step);
    set(handles.new_time_set_input,'Enable','on','string',num2str(handles.current_step));
elseif(isequal(handles.data_id,3))
    slider_step = [1.0/(length(handles.sta_name)-1),1.0/(length(handles.sta_name)-1)];
    set(handles.change_time_slider,'Enable','on','max',length(handles.sta_name),'min',1,'Value',handles.current_step,'sliderstep',slider_step);
    set(handles.new_time_set_input,'Enable','on','string',num2str(handles.current_step));
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function new_time_set_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_time_set_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function change_time_slider_Callback(hObject, eventdata, handles)
% hObject    handle to change_time_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.current_step = floor(get(hObject,'Value'));
set(handles.new_time_set_input,'string',num2str(floor(get(hObject,'Value'))));
gene_fig_button_Callback(hObject, eventdata, handles);
handles = guidata(hObject);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function change_time_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to change_time_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function xmin_input_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of xmin_input as text
%        str2double(get(hObject,'String')) returns contents of xmin_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'xmin','xlim',input);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function xmin_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_input_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of xmax_input as text
%        str2double(get(hObject,'String')) returns contents of xmax_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'xmax','xlim',input);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xmax_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_input_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ymin_input as text
%        str2double(get(hObject,'String')) returns contents of ymin_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'ymin','ylim',input);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ymin_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_input_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ymax_input as text
%        str2double(get(hObject,'String')) returns contents of ymax_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'ymax','ylim',input);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ymax_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stepmin_input_Callback(hObject, eventdata, handles)
% hObject    handle to stepmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of stepmin_input as text
%        str2double(get(hObject,'String')) returns contents of stepmin_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'stepmin','steplim',input);
if(isequal(handles.data_id,2))
    handles.current_step = handles.stepmin{1};
elseif(isequal(handles.data_id,3))
    handles.current_step = handles.stepmin{2};
else
    handles.current_step = handles.stepmin{3};
end
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function stepmin_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stepmax_input_Callback(hObject, eventdata, handles)
% hObject    handle to stepmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of stepmax_input as text
%        str2double(get(hObject,'String')) returns contents of stepmax_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'stepmax','steplim',input);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function stepmax_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in x_scale_switch.
function x_scale_switch_Callback(hObject, eventdata, handles)
% hObject    handle to x_scale_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of x_scale_switch
if(isequal(get(hObject,'Value'),0))
    set(handles.x_scale_input,'Enable','off','string','1');
    handles.x_scale = 1;
else
    set(handles.x_scale_input,'Enable','on','string',num2str(handles.x_scale));
end
guidata(hObject, handles);


function x_scale_input_Callback(hObject, eventdata, handles)
% hObject    handle to x_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of x_scale_input as text
%        str2double(get(hObject,'String')) returns contents of x_scale_input as a double
handles.x_scale = str2double(get(hObject,'String'));
if(isnan(handles.x_scale))
    if (~isempty(get(hObject,'String')))
        handles.x_scale = 1;
        set(hObject,'string','1');
        uicontrol(hour_input);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function x_scale_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in y_scale_switch.
function y_scale_switch_Callback(hObject, eventdata, handles)
% hObject    handle to y_scale_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of y_scale_switch
if(isequal(get(hObject,'Value'),0))
    set(handles.y_scale_input,'Enable','off','string','1');
    handles.y_scale = 1;
else
    set(handles.y_scale_input,'Enable','on','string',num2str(handles.y_scale));
end
guidata(hObject, handles);



function y_scale_input_Callback(hObject, eventdata, handles)
% hObject    handle to y_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of y_scale_input as text
%        str2double(get(hObject,'String')) returns contents of y_scale_input as a double
handles.y_scale = str2double(get(hObject,'String'));
if(isnan(handles.y_scale))
    if (~isempty(get(hObject,'String')))
        handles.y_scale = 1;
        set(hObject,'string','1');
        uicontrol(hour_input);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function y_scale_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in z_scale_switch.
function z_scale_switch_Callback(hObject, eventdata, handles)
% hObject    handle to z_scale_switch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of z_scale_switch
if(isequal(get(hObject,'Value'),0))
    set(handles.z_scale_input,'Enable','off','string','1');
    handles.z_scale = 1;
    if(isequal(handles.parameter_id,6))
        handles.D3 = 0;
    end
else
    set(handles.z_scale_input,'Enable','on','string',num2str(handles.z_scale));
    if(isequal(handles.parameter_id,6))
        handles.D3 = 1;
    end
end
guidata(hObject, handles);



function z_scale_input_Callback(hObject, eventdata, handles)
% hObject    handle to z_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of z_scale_input as text
%        str2double(get(hObject,'String')) returns contents of z_scale_input as a double
handles.z_scale = str2double(get(hObject,'String'));
if(isnan(handles.z_scale))
    if (~isempty(get(hObject,'String')))
        handles.z_scale = 1;
        set(hObject,'string','1');
        uicontrol(hour_input);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function z_scale_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_scale_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmin_input_Callback(hObject, eventdata, handles)
% hObject    handle to zmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of zmin_input as text
%        str2double(get(hObject,'String')) returns contents of zmin_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'zmin','zlim',input);
if(isequal(handles.data_id,2))
    handles.current_layer = handles.zmin{1};
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function zmin_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmax_input_Callback(hObject, eventdata, handles)
% hObject    handle to zmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of zmax_input as text
%        str2double(get(hObject,'String')) returns contents of zmax_input as a double
input = str2double(get(hObject,'String'));
handles = post_check_input(handles,'zmax','zlim',input);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function zmax_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function plot_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate plot_axes
set(gca,'XColor',[1 1 1])
set(gca,'YColor',[1 1 1])
set(gca,'XTickLabel',[])
set(gca,'YTickLabel',[])



function new_time_set_input_Callback(hObject, eventdata, handles)
% hObject    handle to new_time_set_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of new_time_set_input as text
%        str2double(get(hObject,'String')) returns contents of new_time_set_input as a double
old_value = floor(get(handles.change_time_slider,'Value'));
input_value = str2double(get(hObject,'String'));
if(isnan(input_value))
    if (~isempty(get(hObject,'String')))
        set(hObject,'string',num2str(old_value));
        uicontrol(hObject);
        uiwait(msgbox('所输入的字符非法，请输入数字！','错误','error'));
    end
else
    if(isequal(handles.data_id,2))
        if(input_value>handles.stepmax{1}||input_value<handles.stepmin{1})
            set(hObject,'string',num2str(old_value));
            uicontrol(hObject);
            uiwait(msgbox(['所输入数据:',num2str(input_value),' 不在时间步区间:[',num2str(handles.stepmin{1}),',',num2str(handles.stepmax{1}),']内!'],'错误','error'));
            return
        else
            handles.current_step = input_value;
        end
    elseif(isequal(handles.data_id,3))
        if(input_value>length(handles.handles.sta_name)||input_value<1)
            set(hObject,'string',num2str(old_value));
            uicontrol(hObject);
            uiwait(msgbox(['所输入数据:',num2str(input_value),' 不在监测点数量区间:[',num2str(1),',',num2str(length(handles.handles.sta_name)),']内!'],'错误','error'));
            return
        else
            handles.current_step = input_value;
        end
    elseif(isequal(handles.data_id,4))
        if(input_value>handles.stepmax{3}||input_value<handles.stepmin{3})
            set(hObject,'string',num2str(old_value));
            uicontrol(hObject);
            uiwait(msgbox(['所输入数据:',num2str(input_value),' 不在时间步区间:[',num2str(handles.stepmin{3}),',',num2str(handles.stepmax{3}),']内!'],'错误','error'));
            return
        else
            handles.current_step = input_value;
        end
    end
    set(handles.change_time_slider,'Value',floor(handles.current_step));
    gene_fig_button_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);
end
guidata(hObject, handles);


% --- Executes on button press in close_plot.
function close_plot_Callback(hObject, eventdata, handles)
% hObject    handle to close_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1_CloseRequestFcn(hObject, eventdata, handles)

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.figure1);
