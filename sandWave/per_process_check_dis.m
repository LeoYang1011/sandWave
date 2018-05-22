function output = per_process_check_dis(vector,dis,more,nan_id)
if (nargin == 2)
    more = 1;
    nan_id = [];
elseif(nargin == 3)
    nan_id = [];
end
if (length(vector) == 2)
    if (dis > (vector(2) - vector(1)))
        output = 0;
    else
        output = 1;
    end
elseif (length(vector) == 4)
    if (dis > (vector(2) - vector(1))||dis > (vector(4)-vector(3))||...
            (dis/(1.0*more) > (vector(3)-vector(2))))
        output = 0;
    else
        output = 1;
    end
elseif(length(vector) == 3)
    if(isequal(nan_id,2))
        if (dis > (vector(2) - vector(1))||(dis/(1.0*more) > (vector(3)-vector(2))))
            output = 0;
        else
            output = 1;
        end
    else
        if (dis > (vector(3) - vector(2))||(dis/(1.0*more) > (vector(2)-vector(1))))
            output = 0;
        else
            output = 1;
        end
    end
end
end

