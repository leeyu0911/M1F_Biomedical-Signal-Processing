%%
clear
close all


eegf3 = load('SIGNAL_DATA_FILES/eeg2-f3.dat');
eegf4 = load('SIGNAL_DATA_FILES/eeg2-f4.dat');
eegc3 = load('SIGNAL_DATA_FILES/eeg2-c3.dat');
eegc4 = load('SIGNAL_DATA_FILES/eeg2-c4.dat');
eegp3 = load('SIGNAL_DATA_FILES/eeg2-p3.dat');
eegp4 = load('SIGNAL_DATA_FILES/eeg2-p4.dat');
eego1 = load('SIGNAL_DATA_FILES/eeg2-o1.dat');
eego2 = load('SIGNAL_DATA_FILES/eeg2-o2.dat');
eegt3 = load('SIGNAL_DATA_FILES/eeg2-t3.dat');
eegt4 = load('SIGNAL_DATA_FILES/eeg2-t4.dat');


X(:,1) = eegf3;
X(:,2) = eegf4;
X(:,3) = eegc3;
X(:,4) = eegc4;
X(:,5) = eegp3;
X(:,6) = eegp4;
X(:,7) = eego1;
X(:,8) = eego2;
X(:,9) = eegt3;
X(:,10) = eegt4;


cov_X = cov(X);
[V, D] = eig(cov_X); % V is coeff, D is latent or diag(cov(score)), but sort small to big

% somethong biao 
[coeff, score, latent] = pca(X);  % score is X in new Coordinate System and sorted?

cumsum(latent)./sum(latent);  % percentige of component
cov_pc = cov(coeff);
tranMatrix = coeff(:,1:2);  % two of componet can content 85% variance
nX = X * tranMatrix;


figure
for i = 1:10
    subplot(10,1,i)
    plot(score(:,i));
end

%% problem 1
clc
clear
close all

D(:,1) = load('SIGNAL_DATA_FILES/eeg2-f3.dat');
D(:,2) = load('SIGNAL_DATA_FILES/eeg2-f4.dat');
D(:,3) = load('SIGNAL_DATA_FILES/eeg2-c3.dat');
D(:,4) = load('SIGNAL_DATA_FILES/eeg2-c4.dat');
D(:,5) = load('SIGNAL_DATA_FILES/eeg2-p3.dat');
D(:,6) = load('SIGNAL_DATA_FILES/eeg2-p4.dat');
D(:,7) = load('SIGNAL_DATA_FILES/eeg2-o1.dat');
D(:,8) = load('SIGNAL_DATA_FILES/eeg2-o2.dat');
D(:,9) = load('SIGNAL_DATA_FILES/eeg2-t3.dat');
D(:,10) = load('SIGNAL_DATA_FILES/eeg2-t4.dat');


fs = 100;
t = (1:length(D(:,1)))/fs;

[U,S,pc] = svd(D', 0); 
eigen = diag(S); 

cumsum(eigen)./sum(eigen)
R = corrcoef(D);
nR = corrcoef(U);

figure
for i = 1:10
    subplot(10,1,i)
    plot(t, D(:,i))
    axis tight
    axis off
end

figure 
pc = pc(:,1:10);
for i = 1:10
    pc(:,i) = pc(:,i) * eigen(i);
    subplot(10,1,i);
    plot(t,pc(:,i)) 
    xlabel('Time (sec)'); 
    ylabel('PC' + i); 
    axis tight;
    axis off;
end


for i = 1:10
    figure
    plot(t, D(:,i))
    hold on
    plot(t, pc(:,i))
end

%% problem 2
clc
clear
close all

D(:,1) = load('SIGNAL_DATA_FILES/eeg1-f3.dat');
D(:,2) = load('SIGNAL_DATA_FILES/eeg1-f4.dat');
D(:,3) = load('SIGNAL_DATA_FILES/eeg1-c3.dat');
D(:,4) = load('SIGNAL_DATA_FILES/eeg1-c4.dat');
D(:,5) = load('SIGNAL_DATA_FILES/eeg1-p3.dat');
D(:,6) = load('SIGNAL_DATA_FILES/eeg1-p4.dat');
D(:,7) = load('SIGNAL_DATA_FILES/eeg1-o1.dat');
D(:,8) = load('SIGNAL_DATA_FILES/eeg1-o2.dat');


fs = 100;
t = (1:length(D(:,1)))/fs;

[U,S,pc] = svd(D', 0); 
eigen = diag(S); 

cumsum(eigen)./sum(eigen)
R = corrcoef(D);
nR = corrcoef(U);

figure
for i = 1:8
    subplot(8,1,i)
    plot(t, D(:,i))
    axis tight
    axis off
end

figure 
pc = pc(:,1:8);
for i = 1:8
    pc(:,i) = pc(:,i) * eigen(i);
    subplot(8,1,i);
    plot(t,pc(:,i)) 
    xlabel('Time (sec)'); 
    ylabel('PC' + i); 
    axis tight;
    axis off;
end

for i = 1:8
    figure
    plot(t, D(:,i))
    hold on
    plot(t, pc(:,i))
end