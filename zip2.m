close all;  clc ; 
path = 'test2.bmp';
hidePath = 'info.png';
I=imread(path);%读入RGB图像

len = length(I(:, 1, 1));
wid = length(I(1, :, 1));
lenLeft = mod(len, 8);
widLeft = mod(wid, 8);
I(1:lenLeft, :, :) = [];
I(:, 1:widLeft, :) = [];

I1 = I(:, :, 1);
I2 = I(:, :, 2);
I3 = I(:, :, 3);
figure(),imshow(I),title('原输入彩色图像');

fun = @(x) dct2(x);
I1 = blkproc(I1, [8 8], fun);   
I2 = blkproc(I2, [8 8], fun);   
I3 = blkproc(I3, [8 8], fun);   

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
I1 = blkproc(I1, [8 8], fun1); 
I2 = blkproc(I2, [8 8], fun1); 
I3 = blkproc(I3, [8 8], fun1); 

%%
[I1, len, h, w, d] = hideImage(I1, hidePath);
hiddenInfor = revealImage(I1, len, h, w, d);
figure(2); imshow(hiddenInfor);


%%
%DCT逆变换
fun2 = @(x)x.*S;
I1 = blkproc(I1, [8 8], fun2); 
I2 = blkproc(I2, [8 8], fun2); 
I3 = blkproc(I3, [8 8], fun2); 

fun = @(x) idct2(x);
I1 = blkproc(I1, [8 8], fun);    
I2 = blkproc(I2, [8 8], fun);  
I3 = blkproc(I3, [8 8], fun);  
I(:, :, 1) = I1;
I(:, :, 2) = I2;
I(:, :, 3) = I3;
figure(), imshow(I), title('压缩后解析后图像');  