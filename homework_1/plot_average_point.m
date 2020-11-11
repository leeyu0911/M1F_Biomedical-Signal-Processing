subplot_num = 10

for x = 10:5:50
    point_of_x = [];
    for i = 1:slen
        if (i==slen-x+2)
            break
        end
        s = 0;
        for j = 0:x-1
            s = s + ecg(i+j);
        end
        point_of_x = [point_of_x, s / x];
    end
    x5 = (1:slen-x+1) / fs;

    subplot(subplot_num,1,x/5)
    plot(x5, point_of_x)
    axis tight;
    title('Average of x')
    xlabel('Time in seconds');
    ylabel('ECG');
end