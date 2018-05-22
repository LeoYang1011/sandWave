function  main_GUI_run(handles)
if(isequal(handles.claculation_content_status(1),1) || isequal(handles.claculation_content_status(4),1))
    flow = 1;
    wave = 0;
elseif (isequal(handles.claculation_content_status(2),1))
    flow = 0;
    wave = 1;
else
    flow = 1;
    wave = 1;
end
if  flow == 1
    fid_xml = fopen([handles.workpath,'\config_d_hydro.xml'],'wt');
    fclose(fid_xml);
    fid_xml = fopen([handles.workpath,'\config_d_hydro.xml'],'a+');
    % Ð´ÈëÄÚÈÝ
    l1 = '<?xml version="1.0" encoding="iso-8859-1"?>';
    l2 = '<OceanUniCHydro xmlns="http://schemas.OceanUniC.nl/OceanUniCHydro" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://schemas.OceanUniC.nl/OceanUniCHydro http://content.oss.OceanUniC.nl/schemas/d_hydro-1.00.xsd">';
    l3 = '    <documentation>';
    l4 = '        File created by    : OceanUniC, create_config_xml.tcl, Version 1.00';
    l5 = '        File creation date : 06 March 2013, 18:09:37';
    l6 = '        File version       : 1.00';
    l7 = '    </documentation>';
    l8 = '    <control>';
    l9 = '        <sequence>';
    l10 = '            <start>myNameFlow</start>';
    l11 = '        </sequence>';
    l12 = '    </control>';
    l13 = '    <flow2D3D name="myNameFlow">';
    l14 = '        <library>flow2d3d</library>';
    l15 = '        <mdfFile>1.mdf</mdfFile>';
    l16 = '    </flow2D3D>';
    l17 = '    <SandBedOnline>';
    l18 = '        <enabled>true</enabled>';
    l19 = '        <urlFile>1.url</urlFile>';
    l20 = '        <waitOnStart>false</waitOnStart>';
    l21 = '        <clientControl>true</clientControl>';
    l22 = '        <clientWrite>false</clientWrite> ';
    l23 = '    </SandBedOnline>';
    l24 = '</OceanUniCHydro>';
    
    for i = 1:24
        fprintf(fid_xml,'%s\n',eval(['l',num2str(i)]));
    end
    fclose(fid_xml);
end

fid_bat = fopen([handles.workpath,'\run.bat'],'wt');
fclose(fid_bat);
fid_bat = fopen([handles.workpath,'\run.bat'],'a+');

% Ð´ÈëÎÄ¼þÖÐ
line1 = '@ echo off';
line2 = 'set argfile=config_d_hydro.xml';
line3 = 'set mdwfile=1.mdw';
line4 = 'set ARCH=win64';
line5 = ['set D3D_HOME=',handles.solver_path];
line6 = 'set flowexedir=%D3D_HOME%\%ARCH%\flow2d3d\bin';
line7 = 'set waveexedir=%D3D_HOME%\%ARCH%\wave\bin';
line8 = 'set swanexedir=%D3D_HOME%\%ARCH%\swan\bin';
line9 = 'set swanbatdir=%D3D_HOME%\%ARCH%\swan\scripts';
line10 = 'set PATH=%flowexedir%;%PATH%';
line11 = 'start "Hydrodynamic simulation" "%flowexedir%\d_hydro.exe" %argfile%';
line12 = 'title Wave simulation';
line13 = 'set PATH=%waveexedir%;%swanbatdir%;%swanexedir%;%PATH%';
line14 = '"%waveexedir%\wave.exe" %mdwfile% 1';
line15 = 'title %CD%';
if flow == 1&& wave ~= 1
    for i = [1,2,4,5,6,10,11]
        fprintf(fid_bat,'%s\n',eval(['line',num2str(i)]));
    end
end
if flow == 1 && wave == 1
    copyfile([handles.solver_path,'\win64\wave\default\dioconfig.ini'],handles.workpath);
    for i = 1:15
        fprintf(fid_bat,'%s\n',eval(['line',num2str(i)]));
    end
end
if flow ~= 1 && wave == 1
    for j = [1,3,4,5,7,8,9,12]
        fprintf(fid_bat,'%s\n',eval(['line',num2str(j)]));
    end
    fprintf(fid_bat,'%s\n%s\n','set PATH=%waveexedir%;%swanbatdir%;%swanexedir%;%PATH%','"%waveexedir%\wave.exe" %mdwfile% 0',line15);
end
fclose(fid_bat);
now_path = pwd;
cd (handles.workpath);
if flow == 1 && wave ~= 1
    ! run.bat
else
    dos('run &');
end
cd (now_path);

end

