% PlotSpectrogram
% A fun function to plot the spectrogram of the audio
% Helped by ChatGPT
% This function is called as a Method in the WavFileObj object

function [] = PlotSpectrogram(audio_data, sample_rate, nfft)
    % Define the parameters for the spectrogram
    window_length = 1024; % Length of the window (in samples)
    overlap_length = 512; % Length of overlap between adjacent windows (in samples)
    %nfft = 256; % Number of FFT points
    
    % Compute the spectrogram
    [s, f, t] = spectrogram(audio_data, window_length, overlap_length, nfft, sample_rate);
 
    % Plot the spectrogram with the flipped frequency axis
    figure;
    imagesc(t, f, 10*log10(abs(s))); % Convert to decibels using 10*log10(abs(s))
    axis xy; % Set the y-axis direction to be normal
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title('Spectrogram with Flipped Frequency Axis');
    colorbar; % Add a color bar to indicate the magnitude

    set(gca, 'YDir','reverse')

end