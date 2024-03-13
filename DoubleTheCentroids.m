function doubled_array = DoubleTheCentroids(input_array, err)
    % Get the size of the input array
    [rows, cols] = size(input_array);
    
    % Initialize the doubled array
    doubled_array = zeros(2 * rows, cols);
    
    % Iterate over each row in the input array
    for i = 1:rows
        % Compute the modified rows
        modified_row_1 = input_array(i, :) .* (1 - err);
        modified_row_2 = input_array(i, :) .* (1 + err);
        
        doubled_array(2*i - 1, :) = modified_row_1;
        doubled_array(2*i, :) = modified_row_2;
    end
end
