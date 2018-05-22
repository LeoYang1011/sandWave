function output = pre_process_generat_grid( vector,dis,more,nan_id)
if (nargin == 2)
    more = 1;
    nan_id = NaN;
end
if (length(vector) == 2)
    if (~rem((vector(2)-vector(1)),dis))
        grid = vector(1):((1.0*dis)/more):vector(2);
    else
        grid =linspace(vector(1),vector(2),ceil((vector(2)-vector(1))/((1.0*dis)/more)));
    end
elseif(length(vector) == 4)
    if (~rem((vector(2)-vector(1)),dis))
        grid_l = vector(1):dis:vector(2);
    else
        grid_l = linspace(vector(1),vector(2),ceil((vector(2)-vector(1))/(1.0*dis)));
    end
    if (~rem((vector(3)-vector(2)),((1.0*dis)/more)))
        grid_c = vector(2):(1.0*dis)/more:vector(3);
    else
        grid_c = linspace(vector(2),vector(3),ceil((vector(3)-vector(2))/((1.0*dis)/more)));
    end
    if (~rem((vector(4) - vector(3)),dis))
        grid_r=vector(3):dis:vector(4);
    else
        grid_r = linspace(vector(3),vector(4),ceil((vector(4) - vector(3))/(1.0*dis)));
    end
    [~,num_l]=size(grid_l);
    [~,num_c]=size(grid_c);
    grid=[grid_l(:,1:num_l-1) grid_c(:,1:num_c-1) grid_r];
elseif(length(vector) == 3)
    if(isequal(nan_id,2))
        if (~rem((vector(2)-vector(1)),((1.0*dis)/more)))
            grid_l = vector(1):(1.0*dis)/more:vector(2);
        else
            grid_l = linspace(vector(1),vector(2),ceil((vector(2)-vector(1))/((1.0*dis)/more)));
        end
        if (~rem((vector(3) - vector(2)),dis))
            grid_r=vector(2):dis:vector(3);
        else
            grid_r = linspace(vector(2),vector(3),ceil((vector(3) - vector(2))/(1.0*dis)));
        end
    else
        if (~rem((vector(2)-vector(1)),dis))
            grid_l = vector(1):dis:vector(2);
        else
            grid_l = linspace(vector(1),vector(2),ceil((vector(2)-vector(1))/(1.0*dis)));
        end
        if (~rem((vector(3)-vector(2)),((1.0*dis)/more)))
            grid_r = vector(2):(1.0*dis)/more:vector(3);
        else
            grid_r = linspace(vector(2),vector(3),ceil((vector(3)-vector(2))/((1.0*dis)/more)));
        end
    end
    [~,num_l]=size(grid_l);
    grid=[grid_l(:,1:num_l-1) grid_r];
end
output = grid;
end

