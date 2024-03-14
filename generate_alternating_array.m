% function to make an alternating array, thank you chatgpt

function alternating_array = generate_alternating_array(length)
    % Create an array of alternating 1s and 0s
    alternating_array = repmat([1, 0], 1, ceil(length/2));
    % Trim the array to the desired length
    alternating_array = alternating_array(1:length);

    alternating_array = alternating_array';

    % Start generating alternating array
    oneVector  = -ones(length,1);
    alternating_array = oneVector.^alternating_array;
end
