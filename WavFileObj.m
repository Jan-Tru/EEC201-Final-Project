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
           Data
           SampleRate
           FrameArray
           FFTLength = 256; % Define the FFT Length here for all objects
           FFTArray
           MelPointAmount = 20;
           MelWrapArray;
           MelCepstrumArray;
    end

    methods

        % Constructor
        function obj = WavFileObj(file_path)
            if nargin > 0
                % save the basic object details
                obj.FilePath = file_path;
                [obj.Data, obj.SampleRate] = audioread(file_path);

                % create the frames
                obj.FrameArray = FrameSplitter(obj.Data,obj.SampleRate);
                
                % take the magnitude of the fft of each column and save to
                % FFTArray
                obj.FFTArray = abs(fft(obj.FrameArray,obj.FFTLength));

                obj.MelWrapArray = MelFrequencyWrap( ...
                    obj.MelPointAmount, ...
                    obj.FFTArray, ...
                    obj.FFTLength, ...
                    obj.SampleRate ...
                    );

                obj.MelCepstrumArray = MelCepstrum(obj.MelWrapArray);
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