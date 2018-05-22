function output = per_process_MN2ll(S,x,y )
% fid = fopen('MN_bnd','rt');
% MN = fscanf(fid,'%d',2);
% M1 = MN(1,1);
% N1 = MN(2,1);
% x = fscanf(fid,'%f',M1);
% y = fscanf(fid,'%f',N1);
% [X,Y] = meshgrid(x,y);
dx1 = x(2,1)-x(1,1);
dx2 = x(end,1)-x(end-1,1);
dy1 = y(2,1)-y(1,1);
dy2 = y(end,1)-y(end-1,1);

Bo1 = S(1,1);
Bo = cell2mat(Bo1);
m1 = cell2mat(S(1,2));
n1 = cell2mat(S(1,3));

if isequal(Bo(1:1),'n')
    m1 = m1-1;

    A = [(x(m1,1)+x(m1+1,1))/2,y(end,1)+dy2];

elseif isequal(Bo(1:1),'s')
    m1 = m1-1;

    A = [(x(m1,1)+x(m1+1,1))/2,y(1,1)-dy1];

elseif isequal(Bo(1:1),'e')
    n1 = n1-1;

    A = [x(end,1)+dx2,(y(n1,1)+y(n1+1,1))/2];

elseif isequal(Bo(1:1),'w')
    n1 = n1-1;

    A = [x(end,1)-dx1,(y(n1,1)+y(n1+1,1))/2];

end
output = A;
end

