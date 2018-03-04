clear all; %������б���
clc ;      %����
path = 'C:\Users\admin\Desktop\matlab\homework1\result.jpg';
I=imread(path);%����RGBͼ��
subplot(131);
imshow(I);

%% devide into several 8*8 blocks
len = length(I(:, 1, 1));
wid = length(I(1, :, 1));
W = fix(wid/8);
H = fix(len/8);
blocks = cell(H, W, 3);
for i = 1:H
    for j = 1:W
        for k = 1:3
            blocks{i, j, k} = I((i-1)*8+1:i*8, (j-1)*8+1:j*8, k);
        end
    end
end

%DCT & ����
S = [
16,	11,	10,	16,	24,	40,	51,	61;
12,	12,	14,	19,	26,	58,	60,	55;
14,	13,	16,	24,	40,	57,	69,	56;
14,	17,	22,	29,	51,	87,	80,	62;
18,	22,	37,	56,	68,	109, 103, 77;
24,	35,	55,	64,	81,	104, 113, 92;
49,	64,	78,	87,	103, 121, 120, 101;
72,	92,	95,	98,	112	,100, 103, 99
];

%%decode
for i = 1:H
    for j = 1:W
        for k = 1:3
            %������
            blocks{i, j, k} = round(blocks{i, j, k}.*S); 
            %DTC�任
            blocks{i, j, k} = idct2(blocks{i, j, k});
            %���Ի�
            %temp = reshape(blocks{i, j, k}', 1, 64);
            %sub = [1,2,9,17,10,3,4,11,18,25,33,26,19,12,5,6,13,20,27,34,41,49,42,35,28,21,14,7,8,15,22,29,36,43,50,57,58,51,44,37,30,23,16,24,31,38,45,52,59,60,53,46,39,32,40,47,54,61,62,55,48,56,63,64];
            %blocks{i, j, k} = temp(sub);
        end
    end
end

result = zeros(len, wid, 3);
for i = 1:H
    for j = 1:W
        for k = 1:3
            result((i-1)*8+1:i*8, (j-1)*8+1:j*8, k) = cell2mat(blocks(i, j, k));
        end
    end
end
%
subplot(133);
imshow(result);
