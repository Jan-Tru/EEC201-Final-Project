% What did they call President LBJ after January 22, 1973?
% Lyndon B. Gone-son 
% LBG.m
% The Gray Algothriym is pretty straight foward after watching some indian
% tutorials online

% Documentation is good practice:
% Check out my notes book here:
% https://docs.google.com/document/d/152HAazzLdOS3QUUInrrWwNTqjM8M0xmH5qu6tLAJnzA/edit?usp=sharing
% 

clc;
numTestFiles = 8;
numTrainFiles = 8;
numFiles = 8;
test_objs = LoadMassFiles("test",numTestFiles);
train_objs = LoadMassFiles("train",numTrainFiles);

% Loading in the files again because I want to just work on it
% self-contained first
format short;
%for test input audio objects, k
numCorrect = 0;
for k = 1:numTestFiles
    [minDistance, minIndex, distanceVector] = TestTrainDistanceFinder(k,test_objs,train_objs);
    if minIndex == k
        numCorrect = numCorrect + 1;
    end
end
disp(numCorrect)
numAudioFiles = numTestFiles;
percentCorrect = numCorrect/numAudioFiles;
fprintf('Congratulations, you have %d%% Accuracy\n', percentCorrect*100);

% Columns: Num of Vectors
% Length of Vector: 19, number of features
% n = rows
% m = columns
% [n, m]
% k is how many bundles of the columns you are going to make



MelCA1 = train_objs{1}.MelCepstrumArray;
MelCA2 = train_objs{2}.MelCepstrumArray;
MelCA3 = train_objs{3}.MelCepstrumArray;
MelCA4 = train_objs{4}.MelCepstrumArray;

[N, M] = size(MelCA1);
numTrainFiles;
err = 0.01;


if mod(M, 2) ~= 0
    % If not, decrease the number of columns by 1
    MelCA1 = MelCA1(:, 1:end-1);
    M = M - 1;
end

% You know I had to double it
for k = 1:numTrainFiles
    
    if minIndex == k
        numCorrect = numCorrect + 1;
    end
end
disp(numCorrect)

% Define the error value
err = 0.1;  % Example error value

% Get the size of the original array
[N, M] = size(MelCA1);

% Create a copy of the original array with the error added
dub_MelCA1 = MelCA1 + err;

% Concatenate the original array and the copied array horizontally
dub_MelCA1 = [MelCA1, dub_MelCA1];

% Display the concatenated array
disp(dub_MelCA1);

% Handle NaN values by replacing them with zeros
dub_MelCA1(isnan(dub_MelCA1)) = 0;

% Perform hierarchical clustering
tree = linkage(dub_MelCA1', 'ward', 'euclidean');

% Visualize dendrogram to determine the number of clusters
figure;
dendrogram(tree);
title('Dendrogram');
xlabel('Data Points');
ylabel('Distance');

% Choose the number of clusters using the elbow method
eval_results = evalclusters(dub_MelCA1', 'linkage', 'silhouette', 'KList', 1:10);
best_k = eval_results.OptimalK;

% Extract cluster centroids as initial codebook vectors
k = best_k;
clusters = cluster(tree, 'maxclust', k);
initial_codebook = zeros(size(dub_MelCA1, 1), k);
for i = 1:k
    cluster_indices = find(clusters == i);
    initial_codebook(:, i) = mean(dub_MelCA1(:, cluster_indices), 2);
end

% Perform k-means clustering using initial codebook vectors
[idx, codebook] = kmeans(dub_MelCA1', k, 'Start', initial_codebook', 'MaxIter', 1000);

% Evaluate the performance of the clustering using silhouette plots
silhouette_values = silhouette(dub_MelCA1', idx);

% Plot silhouette values
figure;
silhouette(dub_MelCA1', idx);
title('Silhouette Plot');

% Display the resulting codebook
disp('Codebook:');
disp(codebook);


% Assuming 'test_data' contains the test data and 'codebook' contains the codebook vectors

% Transpose test_data if needed to match the dimensions of codebook
if size(MelCA2, 1) ~= size(codebook, 1)
    MelCA2 = MelCA2';
end

% Calculate distances between test data and codebook vectors
distances = pdist2(MelCA2', codebook', 'euclidean'); % Euclidean distance

% Assign labels based on nearest codebook vector
[~, assigned_labels] = min(distances, [], 2);

% Display assigned labels for the test data
disp('Assigned Labels for Test Data:');
disp(assigned_labels);


