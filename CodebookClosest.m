% CodebookClosest.m a function definition to be called in main.m this
% compares the train array vectors to the test array vectors, returning
% which train vector (and train vector index) is closest to each test array
% vector. 
% Each column is shortest distance for between that index's test vector and
% the closest cookbook vector/cookbook vector's index

function [distanceVector, indexVector] = CodebookClosest(TestArray, TrainArray)
    
    % Preallocate distanceVector
    distanceVector = zeros(1,size(TestArray,2));
    indexVector = zeros(1,size(TestArray,2));

    % for every column in MelCep1
    for l = 1:size(TestArray,2)

        % initialize distance to a high number so the value can drop
        distanceCell = 9999999;
 
        % for every column in MelCep2
        for k = 1:size(TrainArray,2)

            % Compare the two vectors
            subt_temp = TestArray(:,l) - TrainArray(:,k);
            dist_temp = sqrt(sum((subt_temp) .^ 2));

            % If the current vector distance is less than the previous one
            % save the value to the cell
            if dist_temp < distanceCell
                distanceCell = dist_temp;
                indexCell = k;
            end

        end

        % Save the value to the cell
        distanceVector(1,l) = distanceCell;
        indexVector(1,l) = indexCell;
    end

    % distanceVector = distanceVector';
    % indexVector = indexVector';
end