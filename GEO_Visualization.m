%% 

clc;
clear all;
close all;

load('Geo20090403011657.mat');
fprintf('The Data is Loaded and is ready for Compression! \n' )

x = Latitude(1:13312);
y = Longitude(1:13312);

%%

%X_C = [];
%Y_C = [];



COMP = [];
MEAN = [];
RMSE = [];
STD = [];
TAU = [];

for i=1:400
    %Tau = 0.00004 + (i*0.000005);
    
    Tau = 0 + (i*0.0000005);
    
    [x_c,y_c,compression_rate] = geoComp(x,y,Tau);
    
    close all;
    
    %X_C = [X_C , x_c];
    %Y_C = [Y_C , y_c];
    COMP = [COMP ; compression_rate];
    
    [Mean_Err, rmse, std] = errorGeo(x,y,x_c,y_c);
    
    MEAN = [MEAN ; Mean_Err];
    RMSE = [RMSE ; rmse];
    STD = [STD; std]; 
    TAU = [TAU; Tau];
    
end



%% 

figure();
plot(COMP,MEAN)

figure();
plot(COMP,RMSE)

figure();
plot(COMP,STD)

figure();
plot(COMP,TAU)
