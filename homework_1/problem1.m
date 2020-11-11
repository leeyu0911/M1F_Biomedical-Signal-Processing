%% 講義做法
clear
close
fs = 1000;
ecg = load('ecg_hfn.dat');
qrs_range = ecg(272:322);
n=length(ecg); 

% 核心計算
[c, lag] = xcorr(ecg, qrs_range);
c=c/max(c);
c1=c(n:(2*n-1));
lag1= lag(n:(2*n-1)); 


subplot(2, 1, 1)
% plot(c(1:(length(c)/2)-1))
plot(lag1/fs,c1); 

subplot(2, 1, 2)
plot(lag1/fs, ecg(1:length(lag1)))




%% Cross-correlation qrs templete
subplot_num = 5;
ecg = load('ecg_hfn.dat');
fs = 1000;  % sampling rate = 1000 Hz
qrs_range = ecg(272:322);

r = xcorr(qrs_range, ecg);  % xcorr corrcoef
r = r(128:length(r));  % offset
y = normalize(r, 'range', [-1, 1]);
x = (1:length(ecg)) / fs;

figure
subplot(subplot_num, 1, 1)
slen = length(ecg);
t=(1:slen)/fs;
plot(t, ecg)
axis tight;
title('ECG')
xlabel('Time in seconds');
ylabel('ECG');

subplot(subplot_num, 1, 2)
plot(x, y(1:length(ecg)))
axis tight;
title('Cross-correlation')
xlabel('Time in second');
ylabel('Cross-correlation');





%% averaged QRS
ecg = load('ecg_hfn.dat');
fs = 1000;
x = (1:length(ecg)) / fs;
wave_length = 716;
coress_offset = 128;
%sample_num = floor(length(ecg) / first_wave);
sample_wave = ecg(1:wave_length);


%for i = 1:length(ecg)
%    if r(i) > 0.8 && r(i-1) < r(i) && r(i+1) < r(i)

averaged_QRS = [sample_wave];
for i = 1:wave_length:length(ecg)
    if (length(ecg) - i) < wave_length
        break
    end
    %disp(i)
    averaged_QRS = [averaged_QRS, ecg(i:i+wave_length-1)];
end

subplot(subplot_num, 1 ,3)
plot(x(1:length(sample_wave)), sample_wave)

subplot(subplot_num, 1 ,4)
plot(x(1:length(averaged_QRS)), averaged_QRS)


subplot(subplot_num, 1 ,5)
plot(x(1:length(mean(averaged_QRS, 2))), mean(averaged_QRS, 2))