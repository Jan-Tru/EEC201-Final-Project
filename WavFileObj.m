% WavFileObj.m Object Definition

% Testing Section
% file_path = "Training_Audio/Zero_train1.wav";
% 
% [audio_data, sample_rate] = audioread(file_path);

% Ty ChatGPT :D
% Define the Class that will store all the data for each audio file
% For organizational purposes of course
classdef WavFileObj
    properties
           ID
           FilePath
           Data
           SampleRate
           FrameLength = 15 % define the time domain length of each frame in milliseconds
           FrameArray
           FrameMaxThreshold = 2 % Define default threshold for the max amplitude of a Frame in FrameArray, Frames with a lesser max amplitude are killed
           WindowedFrameArray;
           FFTLength = 512*2; % Define the FFT Length here for all objects
           FFTArray
           MelPointAmount = 20; % the amount of triangular bins, the code doesn't like you touching this!
           MelWrapArray;
           MelCepstrumArray;
           Codebook;
           Error = 0.35; % changeable LBG error; 0.3 is best so far
           ResampleFactor = 1; % samplerate = samplerate/resamplefactor
           CentroidLoopNumber = 5; % there are 2^(CentroidLoopNumber + 1) Centroids created
    end

    methods

        % Constructor
        function obj = WavFileObj(file_path)
            % if there is an arguent to the constructor
            if nargin > 0
                % save the basic object details
                obj.FilePath = file_path;
                [obj.Data, obj.SampleRate] = audioread(file_path);
                
                % resample the data
                obj.SampleRate = floor(obj.SampleRate/obj.ResampleFactor);
                obj.Data = resample(obj.Data,1,obj.ResampleFactor);

                % add energy normalization to the data and remove its DC
                % values
                % adds a negligible value so that the log(0) doesnt throw
                % zeros so there's a tiny bit of offset
                obj.Data = EnergyNormalizer(obj.Data);

                % create the frames
                obj.FrameArray = FrameSplitter(obj.Data,obj.SampleRate,obj.FrameLength);
                
                % Find frames greater than FrameMaxThreshold max amplitude
                idx = abs(max(obj.FrameArray)) > obj.FrameMaxThreshold;
                
                % Extract frames that meet the condition
                obj.FrameArray = obj.FrameArray(:, idx);

                % Apply the the Hamming window
                obj.WindowedFrameArray = HamWindowMult(obj.FrameArray);

                % take the magnitude of the fft of each column and save to
                % FFTArray
                obj.FFTArray = abs(fft(obj.WindowedFrameArray,obj.FFTLength));

                % Apply a notch filter for robustness testing, comment out
                % otherwise:
                %obj.FFTArray = NotchFilter(obj.FFTArray);

                obj.MelWrapArray = MelFrequencyWrap( ...
                    obj.MelPointAmount, ...
                    obj.FFTArray, ...
                    obj.SampleRate ...
                    );

                obj.MelCepstrumArray = MelCepstrum(obj.MelWrapArray);

                obj.Codebook = GenerateCodebookLoops(obj.MelCepstrumArray,obj.Error,obj.CentroidLoopNumber);
            end
        end
        
        % Method to plot the waveform
        function PlotWaveform(obj)
            plot((1:length(obj.Data)) ./ obj.SampleRate, obj.Data);
            xlabel('Time (s)');
            ylabel('Amplitude');
            title('Waveform');
        end

        % Method to play the audio
        function Play(obj)
            sound(obj.Data, obj.SampleRate);
        end

        % Method to plot FFT of any frame specified by frame_number)
        function PlotFFTFrame(obj,frame_number)
            % Length of one column, ie. one frame
            %N = length(obj.FrameArray(:,1));

            % Compute the frequency vector
            %f = (0:N-1)*(obj.FFTLength/N); % Frequency vector

            stem(obj.FFTArray(:,frame_number))
            xlabel('FFT Samples (n)');
            ylabel('Magnitude');
            title('Magnitude Spectrum (FFT)');
        end
        
        function PlotMelArray(obj)
            PlotMelArray(obj.MelWrapArray)
        end

        function PlotSpectrogram(obj)
            PlotSpectrogram(obj.Data,obj.SampleRate,obj.FFTLength)
        end

        % Method to print the periodogram of the colored waveform using STFT in 3D
        function PlotPeriodogram(obj)
            % Calculate the Short-Time Fourier Transform (STFT)
            [S,F,T] = stft(obj.Data,FFTLength=obj.FFTLength,OverlapLength=floor(128/3));
        
            sample_rate = obj.SampleRate;

            % Create the frequency axis ranging from -sample_rate/2 to sample_rate/2
            frequency_axis = linspace(-sample_rate/2, sample_rate/2, size(S,1));
            
            % Plot the STFT in 3D
            figure;
            surf(T, frequency_axis, abs(S), 'EdgeColor', 'none');
            axis tight;
            colormap(jet);
            view(3); % Change the view to 3D
            xlabel('Time (ms)');
            ylabel('Frequency (Hz)');
            zlabel('Power Magnitude (Absolute)');
            title('STFT Periodogram');
            % Set the frequency axis ticks every 1000 Hz
            yticks(-13000/2:1000:13000/2);
        end
    end
end
