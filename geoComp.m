function [x_c,y_c,compression_rate] = geoComp(x,y,Tau)

% Wavelet Matrix and Inverse Wavelet Matrix
H = gen_wave(1024,4);
Hinv = pinv(H);
fprintf('The Wavelet Matrix and the Inverse Wavelet Matrix is made. \n')

for i=1:(length(x)/1024)
    Lat{i} = x(1+((i-1)*1024):((i)*1024)) ;
    Long{i} = y(1+((i-1)*1024):((i)*1024)) ;
end

fprintf('Compression begins! \n')
t_comp = cputime;

for i = 1:13
    
X{i} = H*Lat{i};
Y{i} = H*Long{i};

r1 = 0;
    for j = 1:1024
        if abs(X{i}(j)) < Tau
            X{i}(j) = 0;
            r1 = r1+1;
        end
    end
    
    
r2 = 0;
    for j = 1:1024
            if abs(Y{i}(j)) < Tau
                Y{i}(j) = 0;
                r2 = r2+1;
            end
    end
% figure;
%  stem(X);

ind_lat{i} = find(abs(X{i}) ~= 0);
X_transmission{i} = X{i}(ind_lat{i});

ind_long{i} = find(abs(Y{i}) ~= 0);
Y_transmission{i} = Y{i}(ind_long{i});

end

TIME_COMP = cputime - t_comp;
fprintf('Compression ends! \n')
fprintf('Time taken to compress the signal is %f seconds \n',TIME_COMP);


fprintf('Decompression begins! \n')
t_decomp = cputime;


for i=1:(length(x)/1024)

 X_Aft_transmission{i} = zeros(1024,1);
 Y_Aft_transmission{i} = zeros(1024,1);
 
 N1 = length(ind_lat{i});
 N2 = length(ind_long{i});
 
     for j = 1:N1
         X_Aft_transmission{i}(ind_lat{i}(j)) = X_transmission{i}(j);
     end

     for j = 1:N2
         Y_Aft_transmission{i}(ind_long{i}(j)) = Y_transmission{i}(j);
     end
 
x_hat{i} = Hinv*X_Aft_transmission{i};
y_hat{i} = Hinv*Y_Aft_transmission{i};

% figure; 
% plot(xaxis); 
% hold on; plot(x_h{i},'r');
end

x_c = [];
for i = 1:(length(x)/1024)
    x_c = [x_c ; x_hat{i}];
end

y_c = [];
for i = 1:(length(x)/1024)
    y_c = [y_c ; y_hat{i}];
end


TIME_DECOMP = cputime - t_decomp;
fprintf('Decompression ends! \n')
fprintf('Time taken to decompress the signal is %f seconds \n',TIME_DECOMP);

figure; 
plot(x); 
hold on; plot(x_c,'r');
title('Latitude Visualization')

figure; 
plot(y); 
hold on; plot(y_c,'r');
title('Longitude Visualization')

samples_lat = 0;
samples_long = 0;

for i = 1:(length(x)/1024)
    samples_lat = samples_lat + length(ind_lat{i});
    samples_long = samples_long + length(ind_long{i});
end

samples_lat = samples_lat*2;
samples_long = samples_long*2;

compression_rate = 1 - (samples_lat + samples_long)/(length(x) + length(y));

fprintf('Therefore, the Compression rate is %f \n',compression_rate);

end
