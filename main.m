% main.m file for the 201 audio recognition project
% this one's gonna be hella fun

%% Testing section for all the Methods of WavFileObj
clc;

numFiles = 19;
zero_train = LoadMassFiles("Zero_train",numFiles);
zero_test = LoadMassFiles("Zero_test",numFiles);

MelCA1 = zero_train{1}.MelCepstrumArray;
MelCA2 = zero_train{2}.MelCepstrumArray;
MelCA3 = zero_train{3}.MelCepstrumArray;
MelCA4 = zero_train{4}.MelCepstrumArray;

dvect12 = Distance2MelCeps(MelCA1, MelCA2)
dvect13 = Distance2MelCeps(MelCA1, MelCA3);
dvect14 = Distance2MelCeps(MelCA1, MelCA4);

% initialize distance vector
inputArrayNum = 2;
distanceVector = zeros(numFiles,1);
for k = 1:numFiles
    if ~isempty(zero_train{k})
        distanceVector(k,1) = mean( ...
            Distance2MelCeps( ...
                zero_test{inputArrayNum}.MelCepstrumArray, ...
                zero_train{k}.MelCepstrumArray ...
            ))
    else
        % Handle the case where the zero train file does not exist
        distanceVector(k,1) = nan % Set distance to very long
    end
end

[minDistance, minIndex] = min(distanceVector);
fprintf('Index of the minimum element in the distance vector: %d\n', minIndex);


