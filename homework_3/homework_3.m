%% Design a Wiener filter to remove the artifacts in the ECG signal in the file ecg_hfn.dat
clc
clear 
close all

ecg = load('ecg_hfn.dat');
fs = 1000; 
segments = 765;

x = (1:segments) / fs;
y = ecg(1:segments);
y_ = y / max(y);

figure
subplot(3, 1, 1);  % 原始ECG
plot(x, y_)
axis tight;
xlabel('Time in seconds');
title('ECG');

% Wiener filter
% [B,A] = BUTTER(N,Wn,'high')
% [B,A] = BUTTER(N,Wn,'low')  % 低通滤波器
% [B,A] = BUTTER(N,Wn)  % 带通滤波器
% N = 8;
% Wn = [100/(fs/2) 200/(fs/2)];
% [B,A] = butter(8,Wn);
% yy = filter(B,A,y);
% yy = wiener_hopf(ecg, y, length(y))


subplot(3, 1, 2)  % desired signal
% [pxx, f] = periodogram(y, rectwin(length(y)),length(y),fs);
% plot(f, 10*log10(pxx))
method = 'gaussian';
b = smoothdata(y, method);  % desired signal 
plot(x, b)
axis tight
title('Desired ECG signal')

subplot(3, 1, 3)  % wiener filter
n = segments;
bb = wiener_hopf(y', b, n); % Apply Weiner Hopf Equations 
y_wiener = filter(bb, 1, y); %  Filter data using optimum filter weights 
y_wiener = y_wiener / max(y_wiener);

plot(x, y_wiener, 'r'); %  Plot filtered data 
xlabel('Time(sec)'); 
ylabel('y(t)'); 
axis tight
title('After Optimal Filtering');

figure
% subplot(211)
[y_p1, x_p1] = periodogram(y,rectwin(length(y)),length(y),fs);
% subplot(212)
[y_p2, x_p2] = periodogram(y_wiener,rectwin(length(y_wiener)),length(y_wiener),fs);
plot(x_p1, 10*log10(y_p1), x_p2, 10*log10(y_p2))
xlabel('Hz')
title('ECG signal PSD')
legend('Original', 'Wiener filter')

%% Create a piecewise linear model

ecg = load('ecg_hfn.dat');
fs = 1000; 
segments = 765;
x = (1:segments) / fs;
y = ecg(1:segments);

figure
subplot(2, 1, 1);
plot(x, y)
axis tight;
xlabel('Time in seconds');
ylabel('ECG');

yy = [];
for i = 1:segments
    if i<100
        yy = [yy, y(1)];
    elseif i<132
        m = (y(132) - y(1)) / (x(132) - x(100));
        y1 = m * (x(i)-x(100)) + y(1);
        yy = [yy, y1];
        
    elseif i<160
        yy = [yy, y(132)];
        
    elseif i<196
        m = (y(196) - y(132)) / (x(196) - x(160));
        y1 = m * (x(i)-x(160)) + y(132);
        yy = [yy, y1];
        
    elseif i<272
        yy = [yy, y(196)];
        
    elseif i<294
        m = (y(294) - y(196)) / (x(294) - x(272));
        y1 = m * (x(i)-x(272)) + y(196);
        yy = [yy, y1];
        
    elseif i<326
        m = (y(326) - y(294)) / (x(326) - x(294));
        y1 = m * (x(i)-x(294)) + y(294);
        yy = [yy, y1];
        
    elseif i<352
        m = (y(352) - y(326)) / (x(352) - x(326));
        y1 = m * (x(i)-x(326)) + y(326);
        yy = [yy, y1];
        
    elseif i<477
        m = (y(477) - y(352)) / (x(447) - x(352));
        y1 = m * (x(i)-x(352)) + y(352);
        yy = [yy, y1];
        
    elseif i<535
        m = (y(535) - y(477)) / (x(535) - x(477));
        y1 = m * (x(i)-x(477)) + y(476);
        yy = [yy, y1];
        
    elseif i<571
        yy = [yy, yy(534)];
        
    elseif i<646
        m = (y(646) - y(571)) / (x(646) - x(571));
        y1 = m * (x(i)-x(571)) + yy(570);
        yy = [yy, y1];
        
    else
        yy = [yy, yy(645)];
        
    end

end


subplot(2, 1, 2)
plot(x(1:length(yy)), yy)
axis tight


%% Redo the above exp by using the ECG filtered by the Comb filter as the template.

ecg = load('ecg_hfn.dat');
segments = 765;
% ecg = ecg(1:segments);
nfft=segments;
fs = 1000;
f=(0:((nfft/2)-1))*fs/nfft;

%
h_comb=[0.631 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310]; 
comb=conv(ecg(1:nfft), h_comb); 

figure 
subplot(311) 
plot((1:nfft)/fs,comb(1:nfft)) 
axis tight; 
xlabel('Time in seconds'); 
title('Low-passed ECG after Comb'); 
axis tight 
grid; 

%
subplot(312) 
% Y_comb=fft(comb(1:nfft),nfft); 
% PS_comb=abs(Y_comb).^2; 
% PS_comb=PS_comb/PS_comb(1); 
% plot(f, 10*log10(PS_comb(1:((nfft/2))))); 
% axis([0 500 -80 0]) 
% grid; 
% xlabel('Hz'); 
% ylabel('dB');
x = (1:segments) / fs;
y = ecg(1:segments);
% periodogram(y,rectwin(length(y)),length(y),fs)

periodogram(y_wiener,rectwin(length(y_wiener)),length(y_wiener),fs);
xline(60,'-.r');
xline(180,'-.r');
xline(300,'-.r');
xline(420,'-.r');
yline(-50, '--r');


subplot(313)
periodogram(comb(1:nfft),rectwin(length(comb(1:nfft))),length(comb(1:nfft)),fs)
xline(60,'-.r');
xline(180,'-.r');
xline(300,'-.r');
xline(420,'-.r');
yline(-50, '--r');

%% Compare the results with the results of the lowpass filter.

figure
[y_w, x_w] = periodogram(y_wiener,rectwin(length(y_wiener)),length(y_wiener),fs);
[y_c, x_c] = periodogram(comb(1:nfft),rectwin(length(comb(1:nfft))),length(comb(1:nfft)),fs);
p1 = plot(x_w, 10*log10(y_w));
hold on
p2 = plot(x_c, 10*log10(y_c));
xline(60,'-.r');
xline(180,'-.r');
xline(300,'-.r');
xline(420,'-.r');
yline(-50, '--r');
xlabel('Hz')
title('PSD')
legend([p1, p2], {'wiener', 'comb'})
