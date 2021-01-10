function p_t(ecg,fs,name)
% http://mirlab.org/jang/books/audioSignalProcessing/filterApplication_chinese.asp?title=11-1%20Filter%20Applications%20(%C2o%AAi%BE%B9%C0%B3%A5%CE)
% lowpass filter 遞迴 畫出來怪怪的
% y = [0, 1.5]; % initial value
% ecg = ecg5 - mean(ecg5); % 每次代換的變數
% for i=13:length(len)
%     temp = 2*y(end) - y(end-1) + (1/32) * (ecg(i) - 2*(ecg(i-6)) + ecg(i-12));
%     y = [y, temp];
% end
% figure
% plot((1:length(y))/fs, y)

x = (1:length(ecg)) / fs;

% lowpass filter  
% filter doesnt achieve 12 Hz
b = [1 0 0 0 0 0 -2 0 0 0 0 0 1]/32;  %why?
a = [1 -2 1];
ecg = ecg - mean(ecg);
ecg_l = filter(b,a,ecg);
ecg_l = ecg_l/ max(abs(ecg_l));
delay = 6;
figure
set(gcf,'position', get(0,'ScreenSize'));
ax(1)=subplot(321);plot(x, ecg);axis tight;title(name);
ax(2)=subplot(322);plot(x, ecg_l);axis tight;title('Low pass filtered');

% Wn = 12*2/fs;  % dont know why
% N = 3;                                                                  % order of 3 less processing
% [a,b] = butter(N,Wn,'low');                                             % bandpass filtering
% ecg_l = filtfilt(a,b,ecg);
% ecg_l = ecg_l/ max(abs(ecg_l));
% figure
% ax(1)=subplot(311);plot(ecg_l);axis tight;title('Low pass filtered');
% ax(2)=subplot(312);periodogram(ecg_l,rectwin(length(ecg_l)),length(ecg_l),fs);


% highpass filter
% % p(n) = x(n-16) - 1/32( y(n-1) + x(n) - x(n-32) )
% b = [1/32, zeros(1, 15), 1, zeros(1, 32-17), 1/32];
% a = [1 0 1/32]; 
% ecg_h = filter(b,a,ecg_l);  % 不確定要用ecg還是ecg_l

Wn = 5*2/fs;
N = 3;                              % order of 3 less processing
[a,b] = butter(N,Wn,'high');        % bandpass filtering
ecg_h = filtfilt(a,b,ecg_l);        % why?
ecg_h = ecg_h/ max(abs(ecg_h));
ax(3)=subplot(323);plot(x, ecg_h);axis tight;title('High Pass Filtered');


% Derivative Operator
b = [1 2 0 -2 -1].*(1/8)*fs;  % 好像跟講義的不一樣
ecg_d = filtfilt(b,1,ecg_h);
ecg_d = ecg_d/max(ecg_d);
ax(4)=subplot(324);plot(x, ecg_d);axis tight;title('Filtered with the derivative filter');


% Squaring
ecg_s = ecg_d.^2;
ax(5)=subplot(325);plot(x, ecg_s);axis tight;title('Squared');


% Integration
ecg_m = conv(ecg_s ,ones(1 ,round(0.150*fs))/round(0.150*fs));  % N=30 is suitable for fs=200 Hz.
delay = delay + round(0.150*fs)/2;
ax(6)=subplot(326);plot((1:length(ecg_m))/fs, ecg_m);axis tight;
title('Averaged with 30 samples length,Black noise,Green Adaptive Threshold,RED Sig Level,Red circles QRS adaptive threshold');


% Adaptive Thresholding

[pks, locs] = findpeaks(ecg_m, 'MINPEAKDISTANCE', round(0.2*fs));  %,'MinPeakHeight', 0.05
[pks1, locs1] = findpeaks(ecg_m, 'MINPEAKDISTANCE', round(0.2*fs), 'MinPeakHeight', 0.025);

hold on;scatter(locs1/fs, pks1, 'm');

len = length(pks);
SPKI_temp = max(ecg_m(1:2*fs))*1/3;
SPKI = zeros(1,len);
NPKI_temp = mean(ecg_m(1:2*fs))*1/2;
NPKI = zeros(1,len);
thresholdi1 = [NPKI_temp + 0.25*(SPKI_temp - NPKI_temp)];
thresholdi2 = [0.5*thresholdi1(1)];

for i = 1:length(pks)
    if pks(i) > 0.05
        SPKI_temp = 0.125*pks(i) + 0.875*SPKI_temp;
        SPKI(i) = SPKI_temp;
        NPKI(i) = NPKI_temp;
    else
        NPKI_temp = 0.125*pks(i) + 0.875*NPKI_temp;
        NPKI(i) = NPKI_temp;
        SPKI(i) = SPKI_temp;
    end

    thresholdi1 = [thresholdi1, NPKI_temp + 0.25*(SPKI_temp - NPKI_temp)];
    thresholdi2 = [thresholdi2, 0.5*thresholdi1(i)];
end


hold on;yline(0.025, '--r');
hold on;plot(locs/fs, SPKI, '--r', 'LineWidth', 2);
hold on;plot(locs/fs, NPKI, '--k', 'LineWidth', 2);
hold on;plot(locs/fs, thresholdi1(2:end), '--g', 'LineWidth', 2);
hold on;plot(locs/fs, thresholdi2(2:end), '--b', 'LineWidth', 2);
legend('signal', 'peak', '0.05', 'SPKI', 'NPKI', 'thresholdi1', 'thresholdi2')


% Searchback Procedure

% cal avg heart beat rate
avg_locs = [];
for i = 2:length(locs1)
    avg_locs = [avg_locs, locs1(i) - locs1(i-1)];
end

60 / (mean(avg_locs) / fs) 

figure
set(gcf,'position', get(0,'ScreenSize'));
ax(1)=subplot(311);periodogram(ecg,rectwin(length(ecg)),length(ecg),fs);
ax(2)=subplot(312);periodogram(ecg_l,rectwin(length(ecg_l)),length(ecg_l),fs);
ax(3)=subplot(313);periodogram(ecg_h,rectwin(length(ecg_h)),length(ecg_h),fs);
end

