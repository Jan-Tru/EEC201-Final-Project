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
           FilePath
           ID
           Data
           SampleRate
           FrameLength = 15 % define the time domain length of each frame in milliseconds
           FrameArray
           FrameMaxThreshold = 0.05 % Define default threshold for the max amplitude of a Frame in FrameArray, Frames with a lesser max amplitude are killed
           WindowedFrameArray;
           FFTLength = 1024*2; % Define the FFT Length here for all objects
           FFTArray
           MelPointAmount = 20;
           MelWrapArray;
           MelCepstrumArray;
           Codebook;
           Error = 0.3;
           ResampleFactor = 1; % samplerate = samplerate/resamplefactor
    end

    methods

        % Constructor
        function obj = WavFileObj(file_path)
            if nargin > 0
                % save the basic object details
                obj.FilePath = file_path;
                [obj.Data, obj.SampleRate] = audioread(file_path);
                
                % resample the data
                obj.SampleRate = floor(obj.SampleRate/obj.ResampleFactor);
                obj.Data = resample(obj.Data,1,obj.ResampleFactor);

                % create the frames
                obj.FrameArray = FrameSplitter(obj.Data,obj.SampleRate,obj.FrameLength);
                
                % Find frames greater than 0.009 max amplitude
                idx = max(obj.FrameArray) > obj.FrameMaxThreshold;
                
                % Extract frames that meet the condition
                obj.FrameArray = obj.FrameArray(:, idx);

                % Apply the the Hamming window
                obj.WindowedFrameArray = HamWindowMult(obj.FrameArray);

                % take the magnitude of the fft of each column and save to
                % FFTArray
                obj.FFTArray = abs(fft(obj.WindowedFrameArray,obj.FFTLength));

                obj.MelWrapArray = MelFrequencyWrap( ...
                    obj.MelPointAmount, ...
                    obj.FFTArray, ...
                    obj.SampleRate ...
                    );

                obj.MelCepstrumArray = MelCepstrum(obj.MelWrapArray);

                obj.Codebook = GenerateCodebook(obj.MelCepstrumArray,obj.Error);
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
    end
end
