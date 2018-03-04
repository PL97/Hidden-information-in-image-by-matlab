function I = hide(I, y)
    %%insert into the pic
    restriction = zeros(1, 3);
    restriction(1) = length(I(:, 1, 1));
    restriction(2) = length(I(1, :, 1));
    restriction(3) = length(I(1, 1, :));
    count = 1;
    flag = 0;
    len = length(y);
    i = 1;
    j = 1;
    k = 1;
    while ~flag
        %end condition
        if count > len
            flag = 1;
            break;
        end
        if I(i, j, k) == 0
            temp = updatesub(i, j, k, restriction);
        end
        %如果插入为0时
        if y(count) == 0
            while I(i, j, k) == 1 || I(i, j, k) == -1
                I(i, j, k) = 0;
                [i, j, k] = updatesub(i, j, k, restriction);
            end
            if mod(I(i, j, k), 2) ~= 0
                I(i, j, k) = I(i, j, k) - 1;
            end
        else
            if mod(I(i, j, k), 2) == 0
                if I(i, j, k) < 0
                    I(i, j, k) = I(i, j, k) + 1;
                else
                    I(i, j, k) = I(i, j, k) - 1;
                end
            end;
        end
        count = count + 1;
        [i, j, k] = updatesub(i, j, k, restriction);
    end
