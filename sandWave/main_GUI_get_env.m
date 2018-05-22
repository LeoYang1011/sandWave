function output = main_GUI_get_env()
currentPath = pwd;
dirOutput = dir(fullfile(currentPath, 'sandWave.lnk'));
if isempty(dirOutput)
    index = strfind(currentPath, filesep);
    path = strrep(currentPath, currentPath(index(2)+1:index(3)-1), 'Public');
    dirOutput = dir(fullfile(path, 'sandWave.lnk'));
end
if isempty(dirOutput)
    output = [currentPath,'\'];
    return
end
filename = {dirOutput.name};
folder = {dirOutput.folder};

file = strcat(folder{1}, filesep, filename{1});
exe_id = fopen(file);
bin = fread(exe_id);
fclose(exe_id);
flags = bin(21);
shellOffset = 77;       % 0x4c
shellLen = 0;
if (bitand(flags, 1)) > 0
    leftShift = bitshift(bin(shellOffset+1), 8);
    leftShift = bitor(leftShift, bin(shellOffset));
    shellLen = leftShift + 2;
end
fileStart = shellOffset + shellLen;
localSysOff = bin(fileStart+16) + fileStart;
len = 0;
while 1
    if bin(localSysOff+len) == 0
        break;
    end
    len = len + 1;
end
fileAbsolutePath = (native2unicode(bin(localSysOff:localSysOff+len-1),'UTF-8'))';
fileAbsolutePath = strcat(fileAbsolutePath);
dirAbsolutePath = fileparts(fileAbsolutePath);
output = dirAbsolutePath;
end

