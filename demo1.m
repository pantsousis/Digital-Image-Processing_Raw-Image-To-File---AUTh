% Demo1 - Demosaicing the image
clc;clear;close all;
%load the data
load('march.mat');
%convert to rgb image
xrgb = bayer2rgb(x);
%show the image
imshow(xrgb);
title('Image demosaicing - bayer2rgb method');