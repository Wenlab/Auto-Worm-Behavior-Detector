load('C:\Users\11097\Nutstore\1\DATA_Wenlab\23.3.10 - N2 taxis Colbert - wo rawdata\data\NC\NC20230312\w1\NC20230312w1_mcd_corred.mat');
mcd = NC20230312w1_mcd;

start_frame = 12140;
end_frame = 15319;
fps = 66;
[x,y] = plot_the_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps);

%% FFT
for f_cutoff = [0.1:0.1:1.0 2:1:5]
    complex_trajectory = x + 1i*y;
    N = length(complex_trajectory);
    fftSignal = fft(complex_trajectory, N);
    
    fs = fps;
    f = fs*(0:(N-1))/N;
    n_cutoff = sum(f<f_cutoff);
    
    filter = zeros(1, N);
    filter(1:n_cutoff) = 1;
    filter(end-n_cutoff+1:end) = 1;
    
    filteredFftSignal = fftSignal .* filter;
    filteredSignal = ifft(filteredFftSignal);
    x_filtered = real(filteredSignal);
    y_filtered = imag(filteredSignal);
    
    %% plot
    figure;
    subplot(1,2,1)
    plot(x,y,'o')
    axis equal
    xlabel('x(mm)');
    ylabel('y(mm)');
    title('Original');
    
    subplot(1,2,2)
    plot(x_filtered,y_filtered,'o')
    axis equal
    xlabel('x filtered(mm)');
    ylabel('y filtered(mm)');
    title('Filtered');
    
    % save
    folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\FFT';
    file_name = ['fcutoff_' num2str(f_cutoff) '.png'];
    file_path = fullfile(folder_path,file_name);
    saveas(gcf,file_path);
    close;
end