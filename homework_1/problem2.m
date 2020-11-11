%% 講義做法

fs = 1000;
ecg = load('ecg_hfn.dat');

for i=1:8 
    h(i)=1/8; 
end
y=conv(ecg(1:1000), h); 

figure 
subplot(211) 
plot((1:1000)/fs,ecg(1:1000)) 
axis tight; 
xlabel('Time in seconds'); 
ylabel('Original ECG'); 
subplot(212) 
plot((1:1000)/fs,y(1:1000)) 
axis tight; 
xlabel('Time in seconds'); 
ylabel('Filtered ECG');

%% 我的作法
ecg = load('ecg_hfn.dat');
fs = 1000; %sampling rate = 1000 Hz
subplot_num = 4;

slen = length(ecg);
x1=(1:slen)/fs;
subplot(4,1,1)
plot(x1, ecg)
axis tight;
title('ECG')
xlabel('Time in seconds');
ylabel('ECG');

%
point_of_2 = [];
for i = 1:slen
    if (i==slen)
        break
    end

    point_of_2 = [point_of_2, (ecg(i) + ecg(i+1)) / 2];
end
x2=(1:slen-1)/fs;

subplot(subplot_num,1,2)
plot(x2, point_of_2)
axis tight;
title('Average of 2')
xlabel('Time in seconds');
ylabel('ECG');

%
point_of_3 = [];
for i = 1:slen
    if (i==slen-1)
        break
    end

    point_of_3 = [point_of_3, (ecg(i) + ecg(i+1) + ecg(i+2)) / 3];
end
x3=(1:slen-2)/fs;

subplot(subplot_num,1,3)
plot(x3, point_of_3)
axis tight;
title('Average of 3')
xlabel('Time in seconds');
ylabel('ECG');

%
point_of_4 = [];
for i = 1:slen
    if (i==slen-2)
        break
    end

    point_of_4 = [point_of_4, (ecg(i) + ecg(i+1) + ecg(i+2) + ecg(i+3)) / 4];
end
x4=(1:slen-3)/fs;

subplot(subplot_num,1,4)
plot(x4, point_of_4)
axis tight;
title('Average of 4')
xlabel('Time in seconds');
ylabel('ECG');

%
%for x = 10:5:50
%    point_of_x = [];
%    for i = 1:slen
%        if (i==slen-x+2)
%            break
%        end
%        s = 0;
%        for j = 0:x-1
%            s = s + ecg(i+j);
%        end
%        point_of_x = [point_of_x, s / x];
%    end
%    x5=(1:slen-x+1)/fs;
%
%    %subplot(subplot_num,1,x/5+4)
%    plot(x5, point_of_x)
%    axis tight;
%    title('Average of x')
%    xlabel('Time in seconds');
%    ylabel('ECG');
%end
