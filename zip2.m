x=imread('test2.bmp'); 
x=rgb2gray(x); 
figure(2);subplot(2,2,1),imshow(x),title('原图'); 
x=im2double(x); 
t=dctmtx(8); 
y = blkproc(x, [8 8], 'P1 * x * P2', t, t'); 
%量化表
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
%量化
y = blkproc(x, [8 8], 'fix(x ./ P1)', S); 

%%
%信息植入
[message, h, w, d] = decompose(hidePath);
figure(2);subplot(2, 2, 3);imshow(imread(hidePath));title('hidden image-origional');
%message = [1, 1, 0, 0, 1];
I = hide(result, message);
x = reveal(I, length(message));
%disp(x);
hiddenInfor = compose(message, h, w, d);
figure(2);subplot(2, 2, 4);imshow(hiddenInfor);title('hidden image-reveal');

%%
%还原
y = blkproc(x, [8 8], 'x .* P1', S); 
y=blkproc(y4,[8 8],'P1*x*P2',t',t);  
figure(2);subplot(2,2,2),imshow(y),title('还原'); 