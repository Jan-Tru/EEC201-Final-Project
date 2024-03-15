%% Testing section for all the Methods of WavFileObj
clc; clear all; close all;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 19;

train_objs = LoadMassFiles("train",numTestFiles);
close all;

test_objs = LoadMassFiles("test",numTrainFiles);
close all;

zero_train = LoadMassFiles("Zero_train",numFiles);
close all;

zero_test = LoadMassFiles("Zero_test",numFiles);
close all;

% twelve_train = LoadMassFiles("Zero_train",numFiles);
% twelve_test = LoadMassFiles("Zero_test",numFiles);


% Initialize cookbook
Cookbook = [];

% Concatenate all the codebooks
for i = 1:numFiles
    % add an indicator number to the top of the codebook
    numCodebookVectors = size(zero_train{i}.Codebook,2);
    tempCodebook = [ones(1,numCodebookVectors)*i ; zero_train{i}.Codebook];

    Cookbook = [Cookbook, tempCodebook];
end

counter = 0;
for i = 1:numFiles
    test1 = zero_test{i}.Codebook;

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

fprintf('Congratulations! \nPercent Correct: %f%%\nNumber Correct: %i\n',100*counter/numFiles,counter)
