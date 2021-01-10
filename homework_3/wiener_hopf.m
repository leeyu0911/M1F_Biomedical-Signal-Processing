function b = wiener_hopf(x,y,maxlags) 
%  Function to compute LMS algol using Weiner-Hopf equations 
%   I nputs: x =  input 
%            y =  desired signal 
%            Maxlags =  filter length 
%  Compute the autocorrelation matrix 
% n =  length(x); 
% l =  length(rxx);

rxx =  xcorr(x,maxlags,'coeff'); 
rxx =  rxx(maxlags+ 1:end-1)'; %  xcorr produces rxx(0) at maxlags+ 1 

rxy =  xcorr(x,y,maxlags); 
rxy =  rxy(maxlags+ 1:end-1)'; 

%  Construct correl matrix and check if singular or ill conditioned 
rxx_matrix =  toeplitz(rxx); 
%  Calculate FIR coefficients 
b =  rxx_matrix \ rxy; %  Levenson could be used here
end