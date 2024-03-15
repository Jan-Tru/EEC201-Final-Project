%% Testing section for all the Methods of WavFileObj
clc;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 8;
epsilon = 0.01;


train_objs = LoadMassFiles("train",numTestFiles);
close all;

test_objs = LoadMassFiles("test",numTrainFiles);
close all;

% zero_train = LoadMassFiles("Zero_train",numFiles);
% zero_test = LoadMassFiles("Zero_test",numFiles);
% 
% twelve_train = LoadMassFiles("Zero_train",numFiles);
% twelve_test = LoadMassFiles("Zero_test",numFiles);


% Initialize cookbook
Cookbook = [];

% Concatenate all the codebooks
for i = 1:numTrainFiles
    % add an indicator number to the top of the codebook
    numCodebookVectors = size(train_objs{i}.Codebook,2);
    tempCodebook = [ones(1,numCodebookVectors)*i ; train_objs{i}.Codebook];

    Cookbook = [Cookbook, tempCodebook];
end

counter = 0;
for i = 1:numTestFiles
    test1 = test_objs{i}.Codebook;

    % Cookbook excluding the first row which is the indicator for which set it
    % came from 
    CookbookWithNoPageNumbers = Cookbook(2:end,:);
    [dist, ind] = CodebookClosest(test1,CookbookWithNoPageNumbers);
    
    % Do the comparison
    Cookbook(1,ind);
    mo = mode(Cookbook(1,ind));
    avg = mean(Cookbook(1,ind));
    fprintf('test: %i ; mode: %i\n',i,mo);
    if mo == i
        counter = counter + 1;
    end
end

fprintf('Congradulations! \nPercent Correct: %f%%\nNumber Correct: %i\n',100*counter/numTestFiles,counter)
