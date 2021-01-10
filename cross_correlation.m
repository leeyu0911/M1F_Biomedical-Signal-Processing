n = (0:15)';
x = 0.84.^n;
y = circshift(x,5);
[c,lags] = xcorr(x,y);
stem(lags,c)

% test var
x1=[5, 3, 54, 93, 83, 22, 17, 19];
x2=rand(20000,1); 
x3 = (1:100)';

for i = 1:3:7
    disp(i)
end
