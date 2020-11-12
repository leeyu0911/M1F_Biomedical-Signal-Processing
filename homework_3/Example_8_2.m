close all; 
clear all; 
fs =  500; %  Sampling frequency 
N =  1024; %  Number of points 
L =  8;                              
%  Optimnal filter order 
f =  (1:N) *  fs/ N;                  
%  Construct freq. vector for plotting 
%  Generate unknown system and noise input 
b_unknown =  [.5 .75 1.2];           
%  Define unknown process 
xn =  randn(1,N); 
xd =  conv(b_unknown,xn);            
%  Generate unknown system output 
xd =  xd(3:N+ 2);                       
%  Truncate extra points % 
%  Apply Weiner filter 
b  =  wiener_hopf(xn,xd,L);          
%  Compute matching filter coefficients 
b =  b/ N;


ps_match =  (abs(fft(b,N))).^ 2; 
ps_unknown =  (abs(fft(b_unknown,N))).^ 2; 
ps_out =  (abs(fft(xd))).^ 2; 
%  
subplot(1,2,1); 
plot(f(1:N/ 2),ps_unknown(1:N/ 2),'k'); 
xlabel('Frequency (Hz)');   
ylabel('| H(z)| '); 
title('Unknown Process'); 
subplot(1,2,2); 
plot(f(1:N/ 2),ps_match(1:N/ 2),'k'); 
xlabel('Frequency (Hz)'); 
ylabel('| H(z)| '); 
title('Matching Process');