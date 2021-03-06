function W = gen_wave(n,L)
p = log2(n);
[h0,h1,f0,f1] = daub(L);
I = eye(n,n);
W = I;
for i = 1:n,
Ii = I(:,i);
W(:,i) = wt(Ii,h0,h1,p);
end
end
