function distance = geodetic2distance(lat1,lng1,lat2,lng2)
R = 6371000; %[m]
lat1 = deg2rad(lat1);
lat2 = deg2rad(lat2);
lng1 = deg2rad(lng1);
lng2 = deg2rad(lng2);
deltaPhi = (lat2-lat1);
deltaTheta = (lng2-lng1);

% a = sin(deltaPhi/2)^2 + cos(lat1) * cos(lat2) * sin(deltaTheta/2)^2;
% 
% c = 2 * atan2(sqrt(a),sqrt(1-a));
x = (lng2-lng1) * cos((lat1+lat2)/2);

y = (lat2-lat1);
distance = R * sqrt(x^2+y^2);%[m]


% distance = R*c;
end