function [Mean_Err, RMSE, STD] = errorGeo(x,y,x_c,y_c)
lat1 = x;
lng1 = y;


lat2 = x_c;
lng2 = y_c;

for i = 1:13312
    Err(i) = geodetic2distance(lat1(i),lng1(i),lat2(i),lng2(i));
end

figure();
plot(Err);

Mean_Err = mean(Err);
RMSE = sqrt(mse(Err));
STD = std(Err);
end
