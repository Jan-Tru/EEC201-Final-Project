%EnergyNormalizer.m A function that is called in the constructor of
%WavFilObj.m. This function takes out the DC component of the waves and
%normalizes thier volumes. This adds a negligible amount of DC offset such
%that we do not have 0 elements

% % Testing section
% numFiles = 1;
% zero_train = LoadMassFiles("Zero_train",numFiles);
% 
% wavData = zero_train{1}.Data;

function outData = EnergyNormalizer(inData)
    % Delete the mean
    avg = mean(inData);
    wavData = inData - avg;
    
    % Calculate the original power
    len = numel(wavData); % Use numel for faster calculation
    originalPower = sum(wavData.^2) / len; % Sum of squares is faster than norm^2
    
    % Normalize our power to 1
    outData = wavData / sqrt(originalPower);

    % Add a log error prevention DC offset
    outData = outData + 0.000000001;
end

