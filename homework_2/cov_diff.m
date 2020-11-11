%% Covariance
% https://www.mathworks.com/help/matlab/ref/cov.html
clc
clear
% A = [5 0 3 7; 1 -5 7 3; 4 9 8 10];
A = [1 2 3 4];
cov(A)
std(A)

s = 0;
for i = 1:4
    s = s + (A(i) - mean(A))^2;
end
s/3
%% Correlation coefficients
% https://www.mathworks.com/help/matlab/ref/corrcoef.html

% If C is the covariance matrix, 
% C = COV(X), then CORRCOEF(X) is the matrix whose 
% (i,j)'th element is C(i,j)/SQRT(C(i,i)*C(j,j)).

x = randn(6,1);
y = randn(6,1);
A = [x y 2*y+3];
R = corrcoef(A)

A = [5 0 3 7; 1 -5 7 3; 4 9 8 10];
C = corrcoef(A)


%% example 1
clc
clear
x(:,1)=[25, 40, 120, 75, 150, 300, 270, 400, 450, 575]'; 
x(:,2)=[30, 80, 150, 80, 200, 350, 240, 320, 470, 583]'; 
mean(x(:,1))
mean(x(:,2))

std(x(:,1)) ^ 2
std(x(:,2)) ^ 2

plot(x(:,1),'bo') 
hold on 
plot(x(:,2),'r*') 
cov(x,1) 
corrcoef(x)

%% example 2
clc
clear
close
N = 256;                    % Number of data points in each  waveform 
n = (1:N)/N;                % Generate 1 sec of data 
x(:,1) = sin(2*pi*n)';      % Generate a 1 Hz sin 
x(:,2) = 2*cos(2*pi*n)';    % Generate a 1 Hz cos 
x(:,3) = 1.5*sin(4*pi*n)';  % Generate a 2 Hz sin 
x(:,4) = 3*cos(4*pi*n)';    % Generate a 2 Hz cos 
x(:,5) = 2.5*sin(3*pi*n)';  % Generate a 1.5 Hz sin 
x(:,6) = 1.75*cos(3*pi*n)'; % Generate a 1.5 Hz cos   
S = cov(x);                  % Print covariance matrix 
C = corrcoef(x);             %  and correlation matrix 
for i = 1:6 
    subplot(2,3,i) 
    plot(x(:,i))
    title(i)
end
figure
plot(x)
legend()


%% Cross-correlation
% https://www.mathworks.com/help/matlab/ref/xcorr.html

A = [1 2 3 4 3 2 1];
n = length(A);
[c, lag] = xcorr(A', 'coeff');
c'
lag1 = lag(n:n+fix(n/2))
plot(c(n:n+fix(n/2)))


%% Cross-covariance
% https://www.mathworks.com/help/matlab/ref/xcov.html

%% moving average filter
% frequency response of hanning filter
clc
close
clear

fs=1000; 
nfft=1024; 
h=(1/4)*[1, 2, 1]; 
f=(0:((nfft/2)-1))*fs/nfft; 
Y=fft(h,nfft); 
PS=abs(Y).^2; 
subplot(211) 
plot(f,PS(1:((nfft/2)))); 
axis tight 
xlabel('Hz'); 
ylabel('Magnitude'); 
subplot(212) 
plot(f,10*log10(PS(1:((nfft/2))))); 
axis tight 
grid; 
xlabel('Hz'); 
ylabel('dB');
 

%% moving average filter
% frequency response of 8-point MA filter
clc
clear
close

fs=1000; 
nfft=1024; 
for i=1:8 
    x(i)=1/8; 
end
f=(0:((nfft/2)-1))*fs/nfft; 
y=fft(x,nfft); 
PS=abs(y).^2; 
subplot(211) 
plot(f,PS(1:((nfft/2)))); 
axis tight 
xlabel('Hz'); 
ylabel('Magnitude'); 
subplot(212) 
plot(f,10*log10(PS(1:((nfft/2))))); 
axis tight 
grid; 
xlabel('Hz'); 
ylabel('dB');

%% Power Spectra of the ECG
ecg = load('./SIGNAL_DATA_FILES/ecg_hfn.dat');
fs=1000; 
nfft=4096; 
f=(0:((nfft/2)-1))*fs/nfft; 
Y_ecg=fft(ecg(1:nfft),nfft); 
PS_ecg=abs(Y_ecg).^2; 
PS_ecg=PS_ecg/PS_ecg(1); 

figure 
subplot(211) 
plot((1:nfft)/fs,ecg(1:nfft)) 
axis tight; 
xlabel('Time in seconds'); 
ylabel('Original ECG'); 
axis tight
grid; 

subplot(212) 
plot(f,10*log10(PS_ecg(1:((nfft/2))))); 
axis([0 500  -80 0]) 
grid; 
xlabel('Hz'); 
ylabel('dB');


%%
parfor i =1:8
    x(i) = 1/8
end

%% Filter design by Weiner Hopf Equations

b  =  conv(b,xn); % Apply Weiner Hopf Equations 
subplot(3,1,2); 
y =  filter(b,1,xn); %  Filter data using optimum filter weights 
plot(t,y,'k'); %  Plot filtered data 
xlabel('Time(sec)'); 
ylabel('y(t)'); 
axis([0 1 1.2* min(y) 1.2* max(y)]) 
title('After Optimal Filtering');