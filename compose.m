function I = compose(message, h, w, z)
    I = zeros(h, w, z);
    for i = 1:h
        for j = 1:w
            for k = 1:z
                begin = ((i-1)*w*z + (j -1)*z + k-1)*8 + 1;
                data = message(begin:begin+7);
                tempBin = bin2dec(num2str(data));
                I(i, j, k) = tempBin;
            end
        end
    end
    disp('showing the hidden picture!');
    I = uint8(I);