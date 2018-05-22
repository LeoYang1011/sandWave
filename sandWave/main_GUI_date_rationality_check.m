function output = main_GUI_date_rationality_check(date_value,month_value,year_value)

leap_year_and_big_month = 0; 
if (~isnan(date_value))
    if (month_value == 2)
        if(date_value > 29)
            index = 0;
        else
            index = 1;
        end
        if(~isnan(year_value))
            if ((rem(year_value,100) ~= 0 && rem(year_value,4) == 0) || rem(year_value,400) == 0)
                leap_year_and_big_month = 1;
                if (date_value > 29)
                    index = 0;
                else
                    index = 1;
                end
            else
                leap_year_and_big_month = 0;
                if (date_value > 28)
                    index = 0;
                else
                    index = 1;
                end
            end
        end
    elseif (ismember(month_value,[1,3,5,7,8,10,12]))
        leap_year_and_big_month = 31;
        if (date_value > 31)
            index = 0;
        else
            index = 1;
        end
    elseif (ismember(month_value,[4,6,9,11]))
        leap_year_and_big_month = 30;
        if (date_value > 30)
            index = 0;
        else
            index = 1;
        end
    end
else
    index = 1;
end

output = [leap_year_and_big_month,index];

end

