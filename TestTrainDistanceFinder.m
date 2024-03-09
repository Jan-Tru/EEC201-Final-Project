% TestTrainDistanceFinder.m

% A function called from main to determine the closest match for every
% audio samples in one object cell array to all the samples in another
% object cell array
function [minDistance, minIndex, distanceVector] = TestTrainDistanceFinder(inputArrayNum, testObj, trainObj)
    numFiles = numel(trainObj);
    distanceVector = zeros(numFiles, 1);
    for k = 1:numFiles
        if ~isa(trainObj{k}, 'double') && ~isa(testObj{inputArrayNum}, 'double') % Check if the object is of type/class WavFileObj
            distanceVector(k, 1) = mean( ...
                Distance2MelCeps(testObj{inputArrayNum}.MelCepstrumArray, trainObj{k}.MelCepstrumArray) ...
                );
        else
            % Handle the case where the object is not of type/class WavFileObj
            distanceVector(k, 1) = nan; % Set distance to very long
        end
    end
    [minDistance, minIndex] = min(distanceVector);

    % Different Print Ouputs
    % fprintf('Test audio num: %i\nIndex minimum element: %i\n\n',inputArrayNum, minIndex);
    %fprintf('For test audio: %i\nIndex of the minimum element in the distance vector: %d\n It has a distance of: %f\n\n',inputArrayNum, minIndex, minDistance);
    fprintf("test: %i ; train: %i\n",inputArrayNum, minIndex)
end

