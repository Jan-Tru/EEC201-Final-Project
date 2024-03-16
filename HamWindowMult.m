% HamWindowMult.m A function for creating and applying a hamming window for the time domain
% frames after framing and before applying the FFT. This function is called
% as part of the constructor in the WavFileObj class.
% Applying a window reduces the sharp transitions in the time domain.

function YN = HamWindowMult(FrameArray)
    YN = [];
    N = size(FrameArray,1);
    for k = 1:size(FrameArray,2)
        xn = FrameArray(:,k); % take one frame out of frame array
        for n = 1:N
            wn = 0.54 - 0.46*cos(2*pi*(n-1)/(N-1)); % Mathmatical def of Hamming window
            YN(n,k) = xn(n)*wn;
        end
    end
end