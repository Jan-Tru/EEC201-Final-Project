%% Testing section for all the Methods of WavFileObj
clc;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 8;
epsilon = 0.01;


test_objs = LoadMassFiles("test",numTestFiles);
train_objs = LoadMassFiles("train",numTrainFiles);
zero_train = LoadMassFiles("Zero_train",numFiles);
zero_test = LoadMassFiles("Zero_test",numFiles);

twelve_train = LoadMassFiles("Zero_train",numFiles);
twelve_test = LoadMassFiles("Zero_test",numFiles);



for i = 1:length(train_objs)
    % Dynamically generate variable name
    var = strcat('MelCA_Train', num2str(i));
    
    % Access MelCepstrumArray and assign it to the dynamically generated variable
    eval([var, ' = train_objs{i}.MelCepstrumArray;']);
end

% % Don't mind me; just cookin' up some codebooks
codebooks = cell(1, numFiles);
fprintf('\nhi1\n')

% Don't mind me; just cookin' up some codebooks
for i = 1:numFiles
    fprintf('\nhi2\n')
        var =  strcat('MelCA_Train', num2str(i));
        fprintf('\nhi3\n')
        codebooks{i} = eval(strcat('LBG(', 'MelCA_Train', num2str(i), ',err)'));
        fprintf('\nhi4\n')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Tasks:
 % fix codebook array. why is it 38x1???
 % 
 %    Do the feature matching


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% do they have a hat on? are they wearing glasses? is their hair curly?

fprintf('\nhi1\n')
% Initialize variables to store distances and closest codebook index
min_distances = zeros(length(codebooks), 1);
closest_index = zeros(length(codebooks), 1);

fprintf('\nhi1\n')
% Iterate over each codebook
for i = 1:length(codebooks)
    % Concatenate the contents of test_objs{i} with itself
    test_objs{i} = [test_objs{i} test_objs{i}];
    
    % Calculate distances between unknown sample and centroids in codebook i
    distances = disteu(test_objs{i}, codebooks{i}); % Using Euclidean distance
    
    % Find the minimum distance and its corresponding index
    [min_dist, idx] = min(distances);
    
    % Store the minimum distance and index
    min_distances(i) = min_dist;
    closest_index(i) = idx;
end

% Find the index of the closest codebook
[~, closest_codebook_idx] = min(min_distances);

% Display the closest codebook index and its corresponding minimum distance
disp(['Closest codebook index: ', num2str(closest_codebook_idx)]);
disp(['Minimum distance: ', num2str(min_distances(closest_codebook_idx))]);


















% format short;
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
% disp(percentCorrect*100);
% fprintf('Congratulations, you have %d%% Accuracy\n', percentCorrect*100);
