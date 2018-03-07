function [result, map] = coding(I)
    len = length(I(1, :));
    wid = length(I(:, 1));
    frequency = tabulate(reshape(I, len*wid, 1));
    num_to_fre = frequency(frequency(:, 2)~=0, :);
    num_to_fre(:, 3) = num_to_fre(:, 3)/100;
    num_to_fre = sortrows(num_to_fre,3);
    code = Haff(num_to_fre(:, 3));
    key = cell(length(code(:, 1)), 1);
    result = cell(len, wid);
    for i = 1:length(num_to_fre)
        subscript = find(I == num_to_fre(i, 1));
        temp_code = code(i, :);
        temp_code(find(isspace(temp_code))) = [];
        result(subscript) = cellstr(temp_code);
        key(i) = cellstr(temp_code);
    end
    result = reshape(result, len*wid, 1);
    map = {num_to_fre(:, 1),key};
end