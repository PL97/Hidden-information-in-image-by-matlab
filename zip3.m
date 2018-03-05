close all;  clc ; 
path = 'test2.bmp';
hidePath = 'info.png';
I=imread(path);%读入RGB图像
I=rgb2gray(I);%转换成灰度图像
figure(),imshow(I),title('原输入彩色图像转化为灰度图像');

len = length(I(:, 1, 1));
wid = length(I(1, :, 1));
lenLeft = mod(len, 8);
widLeft = mod(wid, 8);
I(1:lenLeft, :, :) = [];
I(:, 1:widLeft, :) = [];

fun = @(x) dct2(x);
I = blkproc(I, [8 8], fun);   

%DCT & 量化
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
figure(), imshow(log(abs(I)),[]),title('DCT变换&量化'), colormap(gray(4)), colorbar;

%%
[I, len, h, w, d] = hideImage(I, hidePath);
hiddenInfor = revealImage(I, len, h, w, d);
figure(2); imshow(hiddenInfor);

%%
%DCT逆变换
fun2 = @(x)x.*S;
I = blkproc(I, [8 8], fun2); 

fun = @(x) idct2(x)/255;
I = blkproc(I, [8 8], fun);     
figure(), imshow(I), title('经过DCT变换，然后逆变换的灰度图像');  


