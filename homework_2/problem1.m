%% Show the ACF of the 4.2-4.96 s segments of f3 and o1 channels (eeg1-f3.dat, eeg1-o1.dat)

clear
close all

f3 = load('SIGNAL_DATA_FILES/eeg1-f3.dat');
o1 = load('SIGNAL_DATA_FILES/eeg1-o1.dat');
o2 = load('SIGNAL_DATA_FILES/eeg1-o2.dat');

% subplotNum = ;

% eeg1-f3.dat
fs = 100;
f3_segments = f3(420:496);
n = length(f3_segments);

[c, lag] = xcorr(f3_segments, f3_segments, 'coeff');
% c = c / max(c);
c1 = c(n: (2 * n - 1));
lag1 = lag(n:(2*n-1)); 

figure
% subplot(subplotNum, 1, 1)
plot(lag1 / fs, c1)
xlabel('Delay in seconds'); 
ylabel('ACF'); 
title('eeg1-f3.dat')

% eeg1-o1.dat
fs = 100;
o1_segments = o1(420:496);
n = length(o1_segments);

[c, lag] = xcorr(o1_segments, o1_segments, 'coeff');
% c = c / max(c);
c1 = c(n: (2 * n - 1));
lag1 = lag(n: (2 * n - 1));

figure
% subplot(subplotNum, 1, 2)
plot(lag1 / fs, c1)
xlabel('Delay in seconds'); 
ylabel('ACF'); 
title('eeg1-o1.dat')
 
% eeg1-o2.dat
fs = 100;
o2_segments = o2(420:496);
n = length(f3_segments);

[c, lag] = xcorr(o2_segments, o2_segments, 'coeff');
c1 = c(n: (2 * n - 1));
lag1 = lag(n:(2*n-1)); 

figure
plot(lag1 / fs, c1)
xlabel('Delay in seconds'); 
ylabel('ACF'); 
title('eeg1-o2.dat')


figure
plot(f3)
figure
plot(o1)

%% Show Crosscorrelation of o1 and o2 during 4.72~5.71 secs (eeg1) 

o1 = load('SIGNAL_DATA_FILES/eeg1-o1.dat');
o2 = load('SIGNAL_DATA_FILES/eeg1-o2.dat');

fs = 100;
segments = 472:571;
n = length(segments);

[c, lag] = xcorr(o1(segments), o2(segments), 'coeff');
% c = c / max(c);
c1 = c(n: (2 * n) - 1);
lag1 = lag(n: (2 * n) - 1);

figure
plot(lag1/fs, c1)
xlabel('Delay in seconds'); 
ylabel('ACF'); 
title('Crosscorrelation of o1 and o2')

% transform to dB
fs = 100;
nfft = 64;
f = (0: ((nfft / 2) -1)) * fs / nfft;

Y = fft(o1(segments), nfft);
PS = abs(Y).^2;
PS = PS / PS(1);

figure
plot(f, 10*log10(PS(1:((nfft / 2)))));
xlabel('Hz'); 
ylabel('dB'); 
title('o1(segments)')

% figure
% plot(o1)
% hold on
% plot(o2)

%% Show Crosscorrelation of o1 and f3 during 4.72~5.71 secs (eeg1)

o1 = load('SIGNAL_DATA_FILES/eeg1-o1.dat');
f3 = load('SIGNAL_DATA_FILES/eeg1-f3.dat');

fs = 100;
segments = 472:571;
n = length(segments);

[c, lag] = xcorr(o1(segments), f3(segments), 'coeff');
% c = c / max(c);
c1 = c(n: (2 * n) - 1);
lag1 = lag(n: (2 * n) -1);

figure
plot(lag1/fs, c1)
xlabel('Delay in seconds'); 
ylabel('ACF'); 
title('Crosscorrelation of o1 and f3')

% transform to dB
fs = 100;
nfft = 64;
f = (0: ((nfft / 2) -1)) * fs / nfft;

Y = fft(f3(segments), nfft);
PS = abs(Y).^2;
PS = PS / PS(1);

figure
plot(f, 10*log10(PS(1:((nfft / 2)))));
xlabel('Hz'); 
ylabel('dB'); 
title('f3(segments)')

