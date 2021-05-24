% Demo2 - Resizing the image
clc;clear;close all;
%load the data
load('march.mat');
%convert to rgb image
xrgb = bayer2rgb(x);
%downsample image to 240x320 with nearest neighbour method
xrgbres_1 = myresize(xrgb,240,320,'nearest');
%downsample image to 200x300 with bilinear interpolation method
xrgbres_2 = myresize(xrgb,200,300,'linear');
%Show images
figure(1);
imshow(xrgbres_1);
title('Downsampled image - Nearest neighbour');
figure(2);
imshow(xrgbres_2);
title('Downsampled image - Bilinear interpolation');