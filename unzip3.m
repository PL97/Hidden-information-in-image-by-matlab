%%
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
%%
%读取数据
load('savedI', 'I');
load('savedmap', 'map');
load('savedh', 'h');
load('savedw', 'w');
load('savedh1', 'h1');
load('savedw1', 'w1');
load('savedlen','len');
load('savedd', 'd');
%%
%解码并将信息提取出来
I = decoding(I, map, h, w);
hiddenInfor = revealImage(I, len, h1, w1, d);
figure(2); imshow(hiddenInfor);

%%
%反量化
fun2 = @(x)x.*S;
I = blkproc(I, [8 8], fun2); 

%%
%反DCT变换除255是为了实现单位转换，unit8类型转化层double类型
fun = @(x) idct2(x)/255;
I = blkproc(I, [8 8], fun);     
figure(), imshow(I), title('经过DCT变换，然后逆变换的灰度图像');  