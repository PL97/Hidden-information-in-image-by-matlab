function [result, len, wid, dim] = decompose(path)
    info = imread(path);
    len = length(info(:,1, 1));
    wid = length(info(1, :, 1));
    dim = length(info(1, 1, :));
    result = zeros(1, len*wid*8*3);
    for i = 1:len
        for j = 1:wid
            for r = 1:dim
                temp1 = zeros(1, 8);
                temp2 = dec2bin(info(i, j, r));
                tempLen = length(temp2);
                for k = 1:tempLen
                    temp1(8-tempLen+k) = str2double(temp2(k));
                end
                start = ((i-1)*wid*dim + (j - 1)*dim + r-1)*8 + 1;
                result(start:start+7) = temp1;
            end
        end
    end
    disp('decomposed the image!');