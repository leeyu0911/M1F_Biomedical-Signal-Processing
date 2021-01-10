%% Implement the Pan-tompkins method for QRS detection
clc
clear
close all

ecg3 = load('ECG3.dat');
ecg4 = load('ECG4.dat');
ecg5 = load('ECG5.dat');
ecg6 = load('ECG6.dat');
ecg_1000 = load('ecg_hfn.dat');


fs = 200;
len = 1:4000;

% sub_plot = 4;
% set(gcf,'position', get(0,'ScreenSize'));
% subplot(sub_plot, 1, 1);plot(len/fs, ecg3)
% subplot(sub_plot, 1, 2);plot(len/fs, ecg4)
% subplot(sub_plot, 1, 3);plot(len/fs, ecg5)
% subplot(sub_plot, 1, 4);plot(len/fs, ecg6)


p_t(ecg3, fs, 'ecg3')
p_t(ecg4, fs, 'ecg4')
p_t(ecg5, fs, 'ecg5')
p_t(ecg6, fs, 'ecg6')
p_t(ecg_1000, 1000, 'ecg_hfn')



%% test field

clear
ecg = load('ecg_hfn.dat');

% findpeaks(ecg, 'MinPeakDistance', 600, 'MinPeakHeight', 0.05)

% ecg3 = load('ECG3.dat');
% ecg4 = load('ECG4.dat');
% % ecg5 = load('ECG5.dat');
% ecg6 = load('ECG6.dat');
% 
% fs = 200;
% pan_tompkin(ecg3,fs,1);
% pan_tompkin(ecg4,fs,1);
% pan_tompkin(ecg5,fs,1);
% pan_tompkin(ecg6,fs,1);

pan_tompkin(ecg, 1000, 1);
