%% Apply three-point central-difference operator to the ECG with low-frequency noise (fs=1000 Hz) 

clc
clear
close all

fs = 1000;
nfft = 1024;
ecg = load('SIGNAL_DATA_FILES/ecg_lfn.dat');
n = 8000;
h = 0.5 * [1, 0, -1];
y=conv(ecg, h);

figure %1
plot((1:n) / fs, ecg(1:n)) 
title('ECG with low-frequency noise')
xlabel('Time in seconds'); 
ylabel('Original ECG');

figure %2
plot((1:n) / fs, y(1:n)) 
axis([1 8 -0.5 0.5]);
title('Apply three-point central-difference operator to the ECG')
xlabel('Time in seconds'); 
ylabel('Filtered ECG');

figure %3
periodogram(ecg,rectwin(length(ecg)),length(ecg),fs)

%% Calculate the noise levels of ECGs before and after filtering.

segments = 864:1091;
segments = 1:length(ecg);

fs = 1000;
nfft = 2^12;

f = (0: ((nfft / 2) -1)) * fs / nfft;

% ECG
Y = fft(ecg(segments), nfft);
PS = abs(Y).^2;
PS = PS / max(PS);

figure %4
subplot(2, 1, 1)
plot(f, 10*log10(PS(1:((nfft / 2)))));
xlabel('Frequency in Hz'); 
ylabel('dB'); 
title('Noise levels of ECGs')

% after filter
Y = fft(y, nfft);
PS = abs(Y).^2;
PS = PS / max(PS);

subplot(2, 1, 2)
plot(f, 10*log10(PS(1:((nfft / 2)))));
xlabel('Frequency in Hz'); 
ylabel('dB'); 
title('Noise levels of filtering')

figure %5
periodogram(y,rectwin(length(y)),length(y),fs)

figure %6
Y = fft(y, nfft);
PS = abs(Y).^2;
PS = PS / max(PS);

plot(f, 10*log10(PS(1:((nfft / 2)))));
xlabel('Frequency in Hz'); 
ylabel('dB'); 
title('Noise levels of filtering')
ylim([-400 0])

%% Calculate bpm of the ECG signal

segments = 50;
peak = 1;
jump = 300;

i = 1;
max = 0;
index = [];
while i < length(ecg)
    if ecg(i) > peak
        for j = i:i+segments
            if ecg(i) > max
                max = ecg(i);
                index = [index, i];
            end
        end
        i = i + jump;
        max = 0;
    end
    i = i + 1;
end

sec = 0;
for ii = 2:length(index)
    sec = sec + index(ii) - index(ii-1);
end

one_persec = (sec / (length(index)-1)) / 1000; % 每次幾秒
(1 / one_persec) * 60 % 每分鐘幾次

    




