close all;  clc ; 
path = 'test2.bmp';
hidePath = 'info.png';
I=imread(path);%读入RGB图像
I=rgb2gray(I);%转换成灰度图像
figure(),imshow(I),title('原始图像');
%%
%将图片剪切，使其适合切分成若干8*8
len = length(I(:, 1, 1));
wid = length(I(1, :, 1));
lenLeft = mod(len, 8);
widLeft = mod(wid, 8);
I(1:lenLeft, :, :) = [];
I(:, 1:widLeft, :) = [];
%%
%DCT变换， 对每个8*8的块进行fun函数处理（即dct变换）
fun = @(x) dct2(x);
I = blkproc(I, [8 8], fun);   
%%
%量化
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
fun1 = @(x) fix(x./S);
I = blkproc(I, [8 8], fun1); 
figure(2), imshow(log(abs(I)),[]),title('DCT变换&量化'), colormap(gray(4)), colorbar;
%%
%隐藏图片S，返回隐藏后的I，隐藏信息长度，隐藏图片分辨率，以及d（对于RGBd = 3，灰度为1）
[I, len, h1, w1, d] = hideImage(I, hidePath);

%%
%coding 哈夫曼编码，I是编码之后的数据，map是编码对应的映射
h = length(I(:, 1)); w = length(I(1,:));
[I, map] = coding(I);

% hiddenInfor = revealImage(I, len, h1, w1, d);
% figure(2); imshow(hiddenInfor);
% 
% fun2 = @(x)x.*S;
% I = blkproc(I, [8 8], fun2); 
% 
% fun = @(x) idct2(x)/255;
% I = blkproc(I, [8 8], fun);     
% figure(), imshow(I), title('经过DCT变换，然后逆变换的灰度图像');  
%%
%保存数据
save('savedh','h');
save('savedw', 'w');
%原始图片分辨率
save('savedI', 'I');
save('savedmap', 'map');
%压缩后编码的数据以及编码使用的映射表
save('savedh1', 'h1');
save('savedw1', 'w1');
save('savedd', 'd');
%隐藏图像的分辨率
save('savedlen', 'len');
%写入图像的信息长度
