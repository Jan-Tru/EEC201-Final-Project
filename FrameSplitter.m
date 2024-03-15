% FrameSplitter.m 
% The function to split the audio file to 30ms segments
% This function is called in WavFileObj objects

% Testing Section
    % file_path = "Training_Audio/Zero_train1.wav";
    % zero_train1 = WavFileObj(file_path);
    % 
    % data = zero_train1.Data;
    % sample_rate = zero_train1.SampleRate;

function FrameArray = FrameSplitter(data,sample_rate)
    % define the variable for 30ms/s
    THIRTY_MS = 30/1000;
    
    % determine the amount of samples it takes to cover 30ms
    samples_per_frame = floor(THIRTY_MS*sample_rate);
    
    % zero pad the audio in the time domain so it has enough samples for 
    % an integer number of frames.
    n_zero_pad = samples_per_frame - mod(size(data,1),samples_per_frame);
    data = [data; zeros(floor(n_zero_pad),1)];

    % initialize the frames
    FrameArray = zeros(samples_per_frame,size(data,1)/samples_per_frame);

    % create the frames!
    for k = 1:size(data,1)/samples_per_frame
        FrameArray(:,k) = data(1+samples_per_frame*(k-1) : k*samples_per_frame);
    end
end