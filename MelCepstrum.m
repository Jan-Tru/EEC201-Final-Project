% MelCepstrum.m
% The Mel Cepstrum (DCT of mel-spectrum) created for every Mel Wrap Frame
% This is still called as a method in WavFileObj
% Hope you're reading Jan :D

% Testing Section
% Testing requires chaning the name of the functions to not match the
% filename, ie. change MelCepstrum to Mel1Cepstrum, adding the 1
% file_path = "Training_Audio/Zero_train1.wav";
% 
% zero_train1 = WavFileObj(file_path);
% 
% MelWrapArray = zero_train1.MelWrapArray;
% Mel1Cepstrum(MelWrapArray);

function MelCepstrumArray = MelCepstrum(MelWrapArray)
    % Define the length of each Mel Wrap column, K
    % ie. the number of rows in a column, l
    K = size(MelWrapArray,1);
    MelCepstrumArray = zeros(K,size(MelWrapArray,2));

    % for each column focus on one column, ie one Mel wrap
    for l = 1:size(MelWrapArray,2)
        
        % compute the Mel Cepstrum elementwise for each C
        for n = 0:K-1

            % each C requires a summation over K
            % initialize the Cn value
            Cn = 0;
            for k = 1:K

                % MelWrapArray(row=k,column=l)
                Cn = Cn + log10(MelWrapArray(k,l))*cos(n*(k-0.5)*pi/K);
            end
            
            % Save the value into column "l" row "c"
            MelCepstrumArray(n+1,l) = Cn;
        end
    end
    
    % Take out the DC values, shrinking this horizontally by one frame
    % ie. take out the first column
    % Then take out any NaN by replacing them with 0, may need to debug
    % further
    MelCepstrumArray = MelCepstrumArray(2:end,:);
    MelCepstrumArray(isnan(MelCepstrumArray)) = 0;

    % Print the size for debugging, should be one less freuqncy cell than 
    % the past Array properties (FFTArray, MelWrapArray)
    % size(MelCepstrumArray)
    % MelCepstrumArray
end