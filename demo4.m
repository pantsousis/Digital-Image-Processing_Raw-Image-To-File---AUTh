% Demo4 - Quantizing/Dequantizing the image
clc;clear;close all;
%load the data
load('march.mat');
%1 - Convert to rgb image
xrgb = bayer2rgb(x);
%2 - Resize to 150x200 with linear
xrgb_res = myresize(xrgb,150,200,'linear');
%3 - Quantize image
bits = 3;
xrgb_res_q = imagequant(xrgb_res,1/2^bits,1/2^bits,1/2^bits);
%4 - Save as PPM
filename = 'dip_is_fun.ppm';
saveasppm(xrgb_res_q,filename,2^bits);
%Extra - proof saveasppm works
imshow(filename);
title('PPM file - Resized and Quantized image - 150x200 - 3 bits/color');
