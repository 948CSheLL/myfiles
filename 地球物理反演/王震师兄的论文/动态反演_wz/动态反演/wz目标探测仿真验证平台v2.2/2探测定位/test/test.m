clc;
close all
clear;

load('EdgeCV.mat');

img=1*(EdgeCV>0);
ed=edge(img,1);
% image(edge(img*255,1));
image(img*255);

