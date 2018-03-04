function result = reveal(I, len)
    %%insert into the pic
    restriction = zeros(1, 3);
    restriction(1) = length(I(:, 1, 1));
    restriction(2) = length(I(1, :, 1));
    restriction(3) = length(I(1, 1, :));
    count = 1;
    flag = 0;
    i = 1;
    j = 1;
    k = 1;
    result = zeros(1, len);
    while ~flag
        if count > len
            flag = 1;
            break;
        end
        if I(i, j, k) == 0
            [i, j, k] = updatesub(i, j, k, restriction);
            continue;
        else
            result(count) = mod(I(i, j, k), 2);
        end
        count = count + 1;
        [i, j, k] = updatesub(i, j, k, restriction);
    end