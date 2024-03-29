% Distance2MelCeps.m Function Definition
% A function to determine the distance between two MelCepstrumArrays
% closest points

% The function looks at every MelCepstrumArray frame and find the closest
% one to it in the compared MelCepstrumArray. It calculates the distance
% between the two and saves that value into that frame.

% The output should still have L columns but only one value per column,
% indicating the distance to the closest vector in the compared array

function distanceVector = Distance2MelCeps(MelCep1, MelCep2)
    
    % Preallocate distanceVector
    distanceVector = zeros(1,size(MelCep1,2));

    % for every column in MelCep1
    for l = 1:size(MelCep1,2)

        % initialize distance to a high number so the value can drop
        distanceCell = 9999999;

        % for every column in MelCep2
        for k = 1:size(MelCep2,2)

            % Compare the two vectors
            subt_temp = MelCep1(:,l) - MelCep2(:,k);
            dist_temp = sqrt(sum((subt_temp) .^ 2));

            % If the current vector distance is less than the previous one
            % save the value to the cell
            if dist_temp < distanceCell
                distanceCell = dist_temp;
            end

        end

        % Save the value to the cell
        distanceVector(1,l) = distanceCell;
    end
end