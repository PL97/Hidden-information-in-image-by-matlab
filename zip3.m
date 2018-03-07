close all;  clc ; 
path = 'test2.bmp';
hidePath = 'info.png';
I=imread(path);%����RGBͼ��
I=rgb2gray(I);%ת���ɻҶ�ͼ��
figure(),imshow(I),title('ԭ�����ɫͼ��ת��Ϊ�Ҷ�ͼ��');

len = length(I(:, 1, 1));
wid = length(I(1, :, 1));
lenLeft = mod(len, 8);
widLeft = mod(wid, 8);
I(1:lenLeft, :, :) = [];
I(:, 1:widLeft, :) = [];

fun = @(x) dct2(x);
I = blkproc(I, [8 8], fun);   

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
fun1 = @(x) fix(x./S);
I = blkproc(I, [8 8], fun1); 
figure(), imshow(log(abs(I)),[]),title('DCT�任&����'), colormap(gray(4)), colorbar;

%%
[I, len, h, w, d] = hideImage(I, hidePath);
hiddenInfor = revealImage(I, len, h, w, d);
figure(2); imshow(hiddenInfor);

%%
%coding
h = length(I(:, 1)); w = length(I(1,:));
[I, map] = coding(I);
I = decoding(I, map, h, w);
%%
%DCT��任
fun2 = @(x)x.*S;
I = blkproc(I, [8 8], fun2); 

fun = @(x) idct2(x)/255;
I = blkproc(I, [8 8], fun);     
figure(), imshow(I), title('����DCT�任��Ȼ����任�ĻҶ�ͼ��');  


