close all;
clear all;
clc;

pic=imread('images.jpg');
pic=rgb2gray(pic);
figure
imshow(pic,[0;255]);
title('Original Image')
figure(2)
imhist(pic);
title('Histogram')

