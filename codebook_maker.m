% array to codebook

% import array

array = combinedMatrix;
threshold = 0.001;
err = 0.01;

% Initialize the codebook with the mean of each column as the first centroid
codebook = mean(array, 1, 'omitnan')

[codebook] = DoubleTheCentroids(codebook, err);

   % Initialize array to store indices of closest centroids
    closest_indices = zeros(1, length(array));

% Loop through each row
for i = 1:size(array, 1)
    % Access the current row
    current_row = array(i, :);
    
    % Perform operations on the current row
    disp(['Row ', num2str(i), ':']);
    disp(current_row);
    
    % Add your code here to operate on the current row
    % Loop through each row
    for j = 1:size(codebook, 1)
        % Access the current row
        current_row = array(j, :);
        
        % Perform operations on the current row
        disp(['Row ', num2str(j), ':']);
        disp(current_row);
        
        % Add your code here to operate on the current row


    end
end
