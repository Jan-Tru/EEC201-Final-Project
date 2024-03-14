% IndexMinArray.m create an array that shows 1 if the element is the mimum
% of its row

function minIndexes = IndexMinArray(distanceArray)
    % Find the minimum value in each row
    min_values = min(distanceArray, [], 2);
    
    % Create a logical array indicating where the minimum values are located
    logical_array = distanceArray == min_values;
    
    % Convert the logical array to 1s and 0s
    minIndexes = double(logical_array);
end