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
%��ȡ����
load('savedI', 'I');
load('savedmap', 'map');
load('savedh', 'h');
load('savedw', 'w');
load('savedh1', 'h1');
load('savedw1', 'w1');
load('savedlen','len');
load('savedd', 'd');
%%
%���벢����Ϣ��ȡ����
I = decoding(I, map, h, w);
hiddenInfor = revealImage(I, len, h1, w1, d);
figure(2); imshow(hiddenInfor);

%%
%������
fun2 = @(x)x.*S;
I = blkproc(I, [8 8], fun2); 

%%
%��DCT�任��255��Ϊ��ʵ�ֵ�λת����unit8����ת����double����
fun = @(x) idct2(x)/255;
I = blkproc(I, [8 8], fun);     
figure(), imshow(I), title('����DCT�任��Ȼ����任�ĻҶ�ͼ��');  