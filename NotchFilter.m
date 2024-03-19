% NotchFilter.m
% A simple notch filter that deletes all magnitude for the middle third of
% the signal. activated for robustness testing

function notchedArray = NotchFilter(FFTArray)
    rows = size(FFTArray, 1);
    cols = size(FFTArray, 2);
    for i = 1:cols
        % Calculate the start and end indices for the first half
        start_index_first_half = 1 + floor(rows/10);
        end_index_first_half = floor(rows/2) - floor(rows/10);
        
        % Set the middle third of the first half to 0
        FFTArray(start_index_first_half:end_index_first_half, i) = 0.00000000001;

        % Calculate the start and end indices for the second half
        start_index_second_half = rows - floor(rows/2) + floor(rows/10) + 1;
        end_index_second_half = rows - floor(rows/10);
        
        % Set the middle third of the second half to 0
        FFTArray(start_index_second_half:end_index_second_half, i) = 0.00000000001;
    end
     notchedArray = FFTArray;
%     stem(notchedArray);
%     title("Every Frame for Test 1 layered; Applied Notch Filter")
%     xlabel("FFT Samples")
%     ylabel("Absolute Magnitude")
end
