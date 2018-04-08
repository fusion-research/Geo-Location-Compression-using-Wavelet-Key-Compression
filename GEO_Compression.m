%% Introduction
% This is the code for the compression for the Latitude and Longitude
% coordinates. The code continues with the reconstruction of the signal at
% the cloud. 

%% Preamble 

clc;
clear all;
close all;

load('Geo20090403011657.mat');
fprintf('The Data is Loaded and is ready for Compression! \n' )


%% Data Conversion 

x = Latitude(1:13312);
y = Longitude(1:13312);

%% Using the geoComp function

%Tau = 0.000044; % Compression of 50% 
%Tau = 0.00005; % Compression of 54% 
%Tau = 0.0001;   % Compression of 70%
Tau = 0.00022;   % Compression of 80%
%Tau = 0.001;   % Compression of 93%
%Tau = 0.005;  % Compression of 97%

[x_c,y_c,compression_rate] = geoComp(x,y,Tau);

%% Errors

[Mean_Err, RMSE, STD] = errorGeo(x,y,x_c,y_c);

