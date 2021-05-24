% Demo3 - Quantizing/Dequantizing the image
clc;clear;close all;
%load the data
load('march.mat');
%convert to rgb image
xrgb = bayer2rgb(x);
%quantize image
bits = 3;
xrgb_q = imagequant(xrgb,1/2^bits,1/2^bits,1/2^bits);
%dequantize image
xrgb_dq = imagedequant(xrgb_q,1/2^bits,1/2^bits,1/2^bits);
%show image
imshow(xrgb_dq);
title('Quantized/Dequantized image - 3 bits/color');