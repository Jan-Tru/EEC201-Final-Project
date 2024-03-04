% MelFrequencyWrap.m function definition
% Puts the bins into their triangular bins accoridng to Mel Frequency
% wrapping.

%% Testing Section
% format long;
% 
% file_path = "Training_Audio/Zero_train1.wav";
% zero_train1 = WavFileObj(file_path);
% 
% a = MelFrequencyWrap1( ...
%     zero_train1.MelPointAmount, ...
%     zero_train1.FFTArray, ...
%     zero_train1.FFTLength, ...
%     zero_train1.SampleRate ...
%     );
% figure;
% imagesc(a)
% colorbar;

% Mel Filter function
% From: https://haythamfayek.com/2016/04/21/speech-processing-for-machine-learning.html
function MelWrapArray = MelFrequencyWrap1(melPointAmount, FFTArray, FFTLength, SampleRate)
    lowFreqMel = 0;
    highFreqMel = (2595*log10(1+(SampleRate/2)/700)); % Convert Hz to Mel
    melPoints = linspace(lowFreqMel,highFreqMel,melPointAmount+2); % Space the points evenly in Mel Scale
    hzPoints = 700*(10.^(melPoints./2595)-1); % Convert Mel to Hz

    fftPoints = ceil(mapRange(hzPoints, 0, SampleRate/2, 0, 128)); % Convert Hz to Samples
    
    % For each FFTArray, l, from 1 to the last fft column
    for l = 2:size(FFTArray,2)
        currentFFT = FFTArray(:,l);
        % For each Mel Peak create a bin and add up using a dot product; save the value
        for k = 2:length(fftPoints)-1
            % Creating the triangle for each Mel bin
            rightTriangleHalf = linspace(0,1,fftPoints(k)-fftPoints(k-1)+1);
            leftTriangleHalf = linspace(1,0,fftPoints(k+1)-fftPoints(k)+1);
            triangle = [rightTriangleHalf(1:end-1) leftTriangleHalf];
    
            % Apply the Mel bin to the correct section of the FFT column and 
            % save as one value in the new Mel Wrap column
            currentFFTFrame = currentFFT(int32(fftPoints(k-1)+1):int32(fftPoints(k+1)+1));
            MelWrapArray(k-1,l) = dot(currentFFTFrame,triangle);
        end
    end
end

function y = mapRange(x, min1, max1, min2, max2)
    % Map values from range [min1, max1] to range [min2, max2]
    y = (x - min1) * (max2 - min2) / (max1 - min1) + min2;
end
