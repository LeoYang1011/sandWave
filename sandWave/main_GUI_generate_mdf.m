function output = main_GUI_generate_mdf(handles)

mdf_file_id = fopen([handles.workpath,'\1.mdf'],'wt');
line1 = 'Ident = #Delft3D-FLOW  .03.02 3.41.06.10981#   ';  
line2 = 'Commnt=                                        ';  
line3 = 'Filcco= #1.grd#                                ';  
line4 = 'Fmtcco= #FR#                                   ';  
%% 考虑此处为笛卡尔坐标系预留两行
for i = 1:4
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end


line5 = 'Filgrd= #1.enc#                                ';  
line6 = 'Fmtgrd= #FR#                                   ';  
lc_data = importdata([handles.workpath,'\1.enc']);
row = lc_data.data(2,1);
col = lc_data.data(2,2);
layer = load([handles.workpath,'\layer']);
[lay_n,~] = size(layer);
grid_enc = [row,col,lay_n];
line7 = 'MNKmax= ';  
for i = 5:6
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end
fprintf(mdf_file_id,'%s',line7);
fclose(mdf_file_id);
mdf_file_id = fopen([handles.workpath,'\1.mdf'],'a+');
fprintf(mdf_file_id,'%s %s %s',num2str(grid_enc(1,1)),num2str(grid_enc(1,2)),num2str(grid_enc(1,3)));
fprintf(mdf_file_id,'\n');
fclose(mdf_file_id);

line8 = 'Thick =  ';  
mdf_file_id = fopen([handles.workpath,'\1.mdf'],'a+');
fprintf(mdf_file_id,'%s',line8);
layers = layer';      %注意此处要获取分层的信息！
[layer_m,layer_n] = size(layers);
layer_num = layer_m*layer_n;
fprintf(mdf_file_id,'%10.7e\n',layers(1,1));
fprintf(mdf_file_id,'         %10.7e\n',layers(1,2:end));

line9 = 'Commnt=                                        ';  
line10 = 'Fildep= #1.dep#                                                         '; 
line11 = 'Fmtdep= #FR#                                                             '; 
line12 = 'Commnt=                                                                  '; 
line13 = 'Commnt=                              no. dry points: 0                   '; 
line14 = 'Commnt=                              no. thin dams: 0                    '; 
line15 = 'Commnt=                                                                  '; 

for i = 9:15
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

%% 此处写入计算时间控制

itdate = ['#',num2str(handles.year_start),'-',num2str(handles.month_start,'%02d'),'-',num2str(handles.day_start,'%02d'),'#'];

line16 = ['Itdate= ', itdate];
fprintf(mdf_file_id,'%s\n',line16);

t1s = [num2str(handles.year_start,'%4d'),'-',num2str(handles.month_start,'%02d'),'-',num2str(handles.day_start,'%02d'),' ',num2str(handles.hour_start,'%02d')...
    ':',num2str(handles.min_start,'%02d'),':',num2str(handles.sec_start,'%02d')];
t1 = datevec(t1s);
t2s = [num2str(handles.year_end,'%4d'),'-',num2str(handles.month_end,'%02d'),'-',num2str(handles.day_end,'%02d'),' ',num2str(handles.hour_end,'%02d')...
    ':',num2str(handles.min_end,'%02d'),':',num2str(handles.sec_end,'%02d')];
t2 = datevec(t2s);
tstop = fix(etime(t2,t1)/60);
tstop = num2str(tstop,'%10.7e');

line17 = 'Tunit = #M#                                                              '; 
line18 = 'Tstart=  0.0000000e+000                                                  '; 
line19 = ['Tstop =  ',tstop];

for i = 17:19
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

line20 = ['Dt    = ',num2str(handles.Dt)]; 

%lon_zone = (lon_min+lon_max)/2;
lon_zone = 119;
Tzone = ceil(lon_zone/15);
line21 = ['Tzone = ',num2str(Tzone)]; 
line22 = 'Commnt=                                                                  '; 

for i = 20:22
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

%% 此处判断是否包含泥沙及地貌演变
line23 = 'Sub1  = #    #                                                           '; 
fprintf(mdf_file_id,'%s\n',line23);
index = find(handles.claculation_content_status == 1);
if ~ismember(index,[4,5,6])
    if isequal(index,3)
        line24 = 'Sub2  = #   w#                                                            ';
    else
        line24 = 'Sub2  = #   #                                                            ';
    end
    fprintf(mdf_file_id,'%s\n',line24);
else
    if isequal(index,4)
        line24 = 'Sub2  = # C  #                                                            ';
    elseif ismember(index,[5,6])
        line24 = 'Sub2  = # CW  #                                                            ';
    end
    fprintf(mdf_file_id,'%s\n',line24);
    fprintf(mdf_file_id,'%s\n','Namc1 = #Sediment1           #');
end

line25 = 'Commnt=                                                                  '; 
line26 = 'Wnsvwp= #N#                                                              '; 
line27 = 'Wndint= #Y#                                                              '; 
line28 = 'Commnt=                                                                  '; 
line29 = 'Zeta0 =  0.0000000e+000                                                  '; 
line30 = 'U0    = [.]                                                              '; 
line31 = 'V0    = [.]                                                              '; 
line32 = 'S0    = [.]                                                              '; 

for i = 25:32
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

% 写入泥沙初始条件
if ismember(index,[4,5,6])
    C01 = zeros(layer_num,1);
    line_C01 = 'C01   =  ';
    fprintf(mdf_file_id,'%s',line_C01);
    fprintf(mdf_file_id,'%10.7e\n',C01(1,1));
    fprintf(mdf_file_id,'         %10.7e\n',C01(2:end,1));
end


%% 写入边界信息       
line33 = 'Commnt=                                                                  '; 
line34 = ['Commnt=                              no. open boundaries: ',num2str(handles.opne_bnd_num)]; 
if ~isequal(handles.claculation_content_status(5),1)                                      %% 如果波浪和泥沙开启，不进行水流的计算，则不必写水动力的边界条件
    % 但此处仍有一个问题：不写水动力的边界条件，表明四边都是固壁；如果计算波浪泥沙时，是开阔的，则另论吧。
    line35 = 'Filbnd= #1.bnd#                                                          ';
    line36 = 'Fmtbnd= #FR#                                                             ';
    for i = 33:36
        fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
    end
    if exist([handles.workpath,'\1.bca'],'file')
        fprintf(mdf_file_id,'%s\n','Filana= #1.bca#                                                          ');
        fprintf(mdf_file_id,'%s\n','Fmtana= #FR#                                                             ');
    end
    if exist([handles.workpath,'\1.bct'],'file')
        fprintf(mdf_file_id,'%s\n','FilbcT= #1.bct#                                                          ');
        fprintf(mdf_file_id,'%s\n','FmtbcT= #FR#                                                             ');
    end
    if ismember(index,[4,5,6])
        fprintf(mdf_file_id,'%s\n','FilbcC= #1.bcc#                                  ');
        fprintf(mdf_file_id,'%s\n','FmtbcC= #FR#                                     ');
    end
    %     line37 = 'Filana= #1.bca#                                                          ';
    %     line38 = 'Fmtana= #FR#                                                             ';

end

% 根据是否含泥沙以及边界条件的数量写Thatcher-Harleman（表面和底面）
if ismember(index,[4,5,6])
    if handles.opne_bnd_num == 0
        fprintf(mdf_file_id,'%s\n','Commnt=                              no. open boundaries: 0');
        fprintf(mdf_file_id,'%s\n','Commnt=                              ');
    else
        Rettis = zeros(1,handles.opne_bnd_num);
        fprintf(mdf_file_id,'%s','Rettis=  ');
        fprintf(mdf_file_id,'%10.7e\n',Rettis(1,1));
        fprintf(mdf_file_id,'         %10.7e\n',Rettis(1,2:end));
        
        fprintf(mdf_file_id,'%s','Rettib=  ');
        fprintf(mdf_file_id,'%10.7e\n',Rettis(1,1));
        fprintf(mdf_file_id,'         %10.7e\n',Rettis(1,2:end));
    end
end

line39 = 'Commnt=                                                                  '; 
line40 = 'Ag    =  9.8100000e+000                                                  '; 
line41 = 'Rhow  =  1.0250000e+003                                                  '; 
line42 = 'Alph0 = [.]                                                              '; 
line43 = 'Tempw =  1.5000000e+001                                                  '; 
line44 = 'Salw  =  3.1000000e+001                                                  '; 

if (isequal(handles.claculation_content_status(3),1) || isequal(handles.claculation_content_status(5),1) || isequal(handles.claculation_content_status(6),1))
    line45 = 'Rouwav= #FR84#                                                           ';
else
    line45 = 'Rouwav= #    #                                                           ';
end


line46 = 'Wstres=  6.3000000e-004  0.0000000e+000  7.2300000e-003  1.0000000e+002  '; 
line47 = 'Rhoa  =  1.0000000e+000                                                  '; 
line48 = 'Betac =  5.0000000e-001                                                  '; 
line49 = 'Equili= #N#                                                              '; 

for i = 39:49
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

if layer_num ==1
    line50 = 'Tkemod= #            #                                                   '; 
else
    line50 = 'Tkemod= #K-epsilon   #';
end
line51 = 'Ktemp = 0                                                                '; 
line52 = 'Fclou =  0.0000000e+000                                                  '; 
line53 = 'Sarea =  0.0000000e+000                                                  '; 
line54 = 'Temint= #Y#                                                              '; 
line55 = 'Commnt=                                                                  '; 
line56 = 'Roumet= #C#                                                              '; 
line57 = 'Ccofu =  6.5000000e+001                                                  '; 
line58 = 'Ccofv =  6.5000000e+001                                                  '; 
line59 = 'Xlo   =  0.0000000e+000                                                  '; 
line60 = 'Vicouv=  2.0000000e+000                                                  '; 
line61 = 'Dicouv=  1.0000000e+001                                                  '; 
line62 = 'Htur2d= #N#                                                              '; 

for i = 50:62
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

if layer_num ~= 1
    fprintf(mdf_file_id,'%s\n%s\n','Vicoww=  1.0000000e-006','Dicoww=  1.0000000e-006');
else
    
end

line63 = 'Irov  = 0                                                                '; 
fprintf(mdf_file_id,'%s\n',line63);

if ismember(index,[4,5,6])
    fprintf(mdf_file_id,'%s\n%s\n%s\n%s\n','Filsed= #1.sed#','Fmtsed= #FR#','Filmor= #1.mor#','Fmtmor= #FR#');
end

line64 = 'Commnt=                                                                  '; 
line65 = 'Iter  =      2                                                           '; 
line66 = 'Dryflp= #YES#                                                            '; 

if ~ismember(index,[4,5,6])
    line67 = 'Dpsopt= #MAX#                                                            ';
    line68 = 'Dpuopt= #MEAN#                                                           ';
else
    line67 = 'Dpsopt= #DP#                                                            '; % 还可以设置为max。
    line68 = 'Dpuopt= #MOR#                                                           '; %还可以设置mean。
end

line69 = 'Dryflc=  1.0000000e-001                                                  '; 
line70 = 'Dco   = -9.9900000e+002                                                  '; 
line71 = 'Tlfsmo=  6.0000000e+001                                                  '; 
line72 = 'ThetQH=  0.0000000e+000                                                  '; 
line73 = 'Forfuv= #Y#                                                              '; 
line74 = 'Forfww= #N#                                                              '; 
line75 = 'Sigcor= #N#                                                              '; 
line76 = 'Trasol= #Cyclic-method#                                                  '; 
line77 = 'Momsol= #Cyclic#                                                         '; 
line78 = 'Commnt=                                                                  '; 
line79 = 'Commnt=                              no. discharges: 0                   '; 

for i = 64:79
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

%% 此处为观测点数量及观测点的文

line80 = ['Commnt=                              no. observation points: ',num2str(handles.obs_num)]; 
line81 = 'Filsta= #1.obs#                                                          '; 
line82 = 'Fmtsta= #FR#                                                             '; 
line83 = 'Commnt=                              no. drogues: 0                      '; 
line84 = 'Commnt=                                                                  '; 
line85 = 'Commnt=                                                                  '; 
line86 = 'Commnt=                              no. cross sections: 0               '; 
line87 = 'Commnt=                                                                  '; 
line88 = 'SMhydr= #YYYYY#                                                          '; 
line89 = 'SMderv= #YYYYYY#                                                         '; 
line90 = 'SMproc= #YYYYYYYYYY#                                                     '; 
line91 = 'PMhydr= #YYYYYY#                                                         '; 
line92 = 'PMderv= #YYY#                                                            '; 
line93 = 'PMproc= #YYYYYYYYYY#                                                     '; 
line94 = 'SHhydr= #YYYY#                                                           '; 
line95 = 'SHderv= #YYYYY#                                                          '; 
line96 = 'SHproc= #YYYYYYYYYY#                                                     '; 
line97 = 'SHflux= #YYYY#                                                           '; 
line98 = 'PHhydr= #YYYYYY#                                                         '; 
line99 = 'PHderv= #YYY#                                                            '; 
line100 = 'PHproc= #YYYYYYYYYY#                                           ';
line101 = 'PHflux= #YYYY#                                                 ';
line102 = 'Online= #N#                                                    ';

for i = 80:102
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

if isequal(handles.claculation_content_status(3),1) || isequal(handles.claculation_content_status(5),1) || isequal(handles.claculation_content_status(6),1)
    fprintf(mdf_file_id,'%s\n%s\n','Waqmod= #N#','WaveOL= #Y#');
end
%% 设置存储时间参数

G_ts = [num2str(handles.G_year,'%4d'),'-',num2str(handles.G_month,'%02d'),'-',num2str(handles.G_day,'%02d'),' ',num2str(handles.G_hour,'%02d')...
    ':',num2str(handles.G_min,'%02d'),':',num2str(handles.G_sec,'%02d')];
G_t = datevec(G_ts);
G_tstart = fix(etime(G_t,t1)/60);

O_ts = [num2str(handles.O_year,'%4d'),'-',num2str(handles.O_month,'%02d'),'-',num2str(handles.O_day,'%02d'),' ',num2str(handles.O_hour,'%02d')...
    ':',num2str(handles.O_min,'%02d'),':',num2str(handles.O_sec,'%02d')];
O_t = datevec(O_ts);
O_tstart = fix(etime(O_t,t1)/60);

C_ts = [num2str(handles.C_year,'%4d'),'-',num2str(handles.C_month,'%02d'),'-',num2str(handles.C_day,'%02d'),' ',num2str(handles.C_hour,'%02d')...
    ':',num2str(handles.C_min,'%02d'),':',num2str(handles.C_sec,'%02d')];
C_t = datevec(C_ts);
C_tstart = fix(etime(C_t,t1)/60);

line103 = ['Flmap =  ',num2str(G_tstart,'%10.7e'),' ',num2str(handles.G_delta_t),' ',tstop];
line104 = ['Flhis =  ',num2str(O_tstart,'%10.7e'),' ',num2str(handles.O_delta_t),' ',tstop];


if ~isequal(handles.claculation_content_status(3),1) && ~isequal(handles.claculation_content_status(6),1) && ~isequal(handles.claculation_content_status(5),1)
    line105 = 'Flpp  =  0.0000000e+000 0  0.0000000e+000                      ';
else
    line105 = ['Flpp =  ',num2str(C_tstart,'%10.7e'),' ',num2str(handles.C_delta_t),' ',tstop];
end

line106 = 'Flrst = 1440                                                   ';
line107 = 'Commnt=                                                        ';
line108 = 'Commnt=                                                        ';

for i = 103:108
    fprintf(mdf_file_id,'%s\n',eval(['line',num2str(i)]));
end

mdf_file_status = fclose(mdf_file_id);

output = mdf_file_status;
end

