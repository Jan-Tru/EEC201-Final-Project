% main.m file for the 201 audio recognition project
% this one's gonna be hella fun

%% Testing section for all the Methods of WavFileObj
clc;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 8;

test_objs = LoadMassFiles("test",numTestFiles);
train_objs = LoadMassFiles("train",numTrainFiles);

% zero_train = LoadMassFiles("Zero_train",numFiles);
% zero_test = LoadMassFiles("Zero_test",numFiles);
% twelve_train = LoadMassFiles("Twelve_train",numFiles);
% twelve_test = LoadMassFiles("Twelve_test",numFiles);
% 


% Initialize a cell array to store the nested arrays
train_array = cell(1, numel(train_objs));

% Loop over the elements of train_objs
for i = 1:numel(train_objs)
    % Access the MelCepstrumArray from each object and store it in the nested array
    train_array{i} = train_objs{i}.MelCepstrumArray;
end

% Display the nested array
% disp('train Array:');
% disp(train_array);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize a cell array to store the nested arrays
test_array = cell(1, numel(test_objs));

% Loop over the elements of train_objs
for i = 1:numel(test_objs)
    % Access the MelCepstrumArray from each object and store it in the nested array
    test_array{i} = test_objs{i}.MelCepstrumArray;
end

% Display the nested array
% disp('test Array:');
% disp(test_array);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Initialize a cell array to store the nested arrays
% zero_train_array = cell(1, numel(zero_train));
% 
% % Loop over the elements of train_objs
% for i = 1:numel(zero_train)
%     % Access the MelCepstrumArray from each object and store it in the nested array
%     zero_train_array{i} = zero_train{i}.MelCepstrumArray;
% end
% 
% % Display the nested array
% % disp('zero_train Array:');
% % disp(zero_train_array);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Initialize a cell array to store the nested arrays
% zero_test_array = cell(1, numel(zero_test));
% 
% % Loop over the elements of train_objs
% for i = 1:numel(zero_test)
%     % Access the MelCepstrumArray from each object and store it in the nested array
%     zero_test_array{i} = zero_test{i}.MelCepstrumArray;
% end
% 
% % Display the nested array
% % disp('zero_test Array:');
% % disp(zero_test_array);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  MelCA_Train1 = train_objs{1}.MelCepstrumArray;
% MelCA_Train2 = train_objs{2}.MelCepstrumArray;
% MelCA_Train3 = train_objs{3}.MelCepstrumArray;
% MelCA_Train4 = train_objs{4}.MelCepstrumArray;
% MelCA_Test1 = test_objs{1}.MelCepstrumArray;
% MelCA_Test2 = test_objs{2}.MelCepstrumArray;
% MelCA_Test3 = test_objs{3}.MelCepstrumArray;
% MelCA_Test4 = test_objs{4}.MelCepstrumArray;

% 
% MelCA3 = zero_train{3}.MelCepstrumArray;
% MelCA4 = zero_train{4}.MelCepstrumArray;
% 
% dvect12 = Distance2MelCeps(MelCA1, MelCA2);
% dvect13 = Distance2MelCeps(MelCA1, MelCA3);
% dvect14 = Distance2MelCeps(MelCA1, MelCA4);

format short;
% k = 1;
% [minDistance, minIndex, distanceVector] = TestTrainDistanceFinder(k,zero_test,zero_train);
% disp(distanceVector)

% NAR
%for test input audio objects, k
% numCorrect = 0;
% for k = 1:numTestFiles
%     [minDistance, minIndex, distanceVector] = TestTrainDistanceFinder(k,test_objs,train_objs);
%     if minIndex == k
%         numCorrect = numCorrect + 1;
%     end
% end
% disp(numCorrect)
% numAudioFiles = numTestFiles;
% percentCorrect = numCorrect/numAudioFiles;
% %disp(percentCorrect*100, "%");
% fprintf('Congratulations, you have %d%% Accuracy\n', percentCorrect*100);


 interations = 10;
 err = 0.01;


codebooks = cell(size(train_array));

% for i = 1:numel(train_objs)  % Corrected loop index
%     codebooks{i} = LBG(train_array{i}, interations, err);
% end


% Loop over the elements of train_objs
for i = 1:numel(test_objs)
    % Access the MelCepstrumArray from each object and store it in the nested array
    test_array{i} = test_objs{i}.MelCepstrumArray;
end


% Example data points (replace this with your actual data)
data = combinedMatrix; % 100 points in 2 dimensions

% Number of clusters
k = 10;

% Perform k-means clustering
[idx, centroids] = kmeans(data, k);

% idx contains the cluster indices for each data point
% centroids contains the centroids of the clusters

% Plot the clustered data
gscatter(data(:,1), data(:,2), idx);
hold on;
plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids');
hold off;

% Compute the mean and variance of each centroid vector
num_centroids = size(centroids, 1);
mean_array = zeros(num_centroids, size(centroids, 2)); % Array to store means
variance_array = zeros(num_centroids, size(centroids, 2)); % Array to store variances

for i = 1:num_centroids
    centroid = centroids(i, :);
    mean_array(i, :) = mean(centroid);
    variance_array(i, :) = var(centroid);
end

% Display mean and variance arrays
disp("Mean array:");
disp(mean_array);
disp("Variance array:");
disp(variance_array);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_cells = numel(test_array); % Number of cells in test_array
% Initialize arrays to store average mean and average variance for each cell
avg_mean_array = cell(num_cells, 1);
avg_variance_array = cell(num_cells, 1);

for cell_index = 1:num_cells
    % Get data from the current cell
    test_data = test_array{cell_index};
    
    % Compute mean and variance arrays for the test data set
    num_points = size(test_data, 1);
    mean_array = zeros(num_points, size(test_data, 2)); % Array to store means
    variance_array = zeros(num_points, size(test_data, 2)); % Array to store variances

    for i = 1:num_points
        data_point = test_data(i, :);
        mean_array(i, :) = mean(data_point);
        variance_array(i, :) = var(data_point);
    end
    
    % Calculate the average mean and average variance
    avg_mean = mean(mean_array);
    avg_variance = mean(variance_array);

    % Store average mean and average variance arrays for the current cell
    avg_mean_array{cell_index} = avg_mean;
    avg_variance_array{cell_index} = avg_variance;
    
    % Display average mean and average variance arrays for the current cell
    disp(['Average mean array for cell ', num2str(cell_index), ':']);
    disp(avg_mean);
    disp(['Average variance array for cell ', num2str(cell_index), ':']);
    disp(avg_variance);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize tables to store results
mean_result_table = cell(num_cells, 2);
variance_result_table = cell(num_cells, 2);
average_result_table = cell(num_cells, 2);

for cell_index = 1:num_cells
    % Get test data from the current cell
    test_data = test_array{cell_index};
    
    % Compute mean and variance arrays for the test data set
    num_points = size(test_data, 1);
    mean_array = nan(num_points, size(centroids, 2)); % Initialize mean array with NaN padding
    variance_array = nan(num_points, size(centroids, 2)); % Initialize variance array with NaN padding
    
    for i = 1:num_points
        data_point = test_data(i, :);
        mean_array(i, :) = mean(data_point);
        variance_array(i, :) = var(data_point);
    end
    
    % Calculate Euclidean distance between each test data mean/variance vector
    % and each centroid mean/variance vector
    mean_distances = pdist2(mean_array, centroids, 'euclidean');
    variance_distances = pdist2(variance_array, centroids, 'euclidean');
    
    % Find the index of the centroid with the minimum distance for mean and variance
    [~, mean_centroid_idx] = min(mean_distances, [], 2);
    [~, variance_centroid_idx] = min(variance_distances, [], 2);
    
    % Repeat the cell index to match the dimension of mean_centroid_idx
    repeated_cell_index = repmat(cell_index, numel(mean_centroid_idx), 1);
    
    % Store results in tables
    mean_result_table{cell_index, 1} = repeated_cell_index;
    mean_result_table{cell_index, 2} = mean_centroid_idx;
    
    variance_result_table{cell_index, 1} = repeated_cell_index;
    variance_result_table{cell_index, 2} = variance_centroid_idx;
    
    % Compute the average of mean and variance centroid indices
    average_centroid_idx = round((mean_centroid_idx + variance_centroid_idx) / 2);
    average_result_table{cell_index, 1} = repeated_cell_index;
    average_result_table{cell_index, 2} = average_centroid_idx;
end

% Convert tables to numeric arrays for display
mean_result_table = cell2mat(mean_result_table);
variance_result_table = cell2mat(variance_result_table);
average_result_table = cell2mat(average_result_table);

% Display result tables
disp('Mean Result Table:');
disp(mean_result_table);
disp('Variance Result Table:');
disp(variance_result_table);
disp('Average Result Table:');
disp(average_result_table);

% Given table of x and y values
data = mean_result_table;

% Initialize mode array and corresponding x values
mode_array = zeros(8, 1);
mode_x_values = zeros(8, 1);

% Iterate through x values 1 through 8
for x = 1:8
    % Filter y values corresponding to current x value
    y_values = data(data(:, 1) == x, 2);
    
    % Find mode of y values
    mode_value = mode(y_values);
    
    % Store mode value and corresponding x value
    mode_array(x) = mode_value;
    mode_x_values(x) = x;
end

% Display mode array and corresponding x values
disp('Mode array:');
disp(mode_array);
disp('Corresponding x values:');
disp(mode_x_values);






