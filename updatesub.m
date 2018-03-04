function [i, j, k] = updatesub(i, j, k, restriction)
    imageLength = restriction(1);
    imageWidth = restriction(2);
    imageDimension = restriction(3);
    if k < imageDimension
        k = k + 1;
    elseif j<imageWidth
        k = 1;
        j = j + 1;
    elseif i < imageLength
        k = 1;
        j = 1;
        i = i + 1;
    else
        disp('信息过大！');
    end