
% MATLAB PROGRAM ecg_hfn.m
clear all               % clears all active variables
close all


ecg = load('ecg_hfn.dat');
fs = 1000; 
segments = 865;

slen = length(ecg);
t=[1:slen]/fs;
figure
plot(t(1:segments), ecg(1:segments))
axis tight;
xlabel('Time in seconds');
ylabel('ECG');

