%% Testing section for all the Methods of WavFileObj
clc; clear; close all;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 19;

train_objs = LoadMassFiles("train",numTestFiles);
test_objs = LoadMassFiles("test",numTrainFiles);
zero_train = LoadMassFiles("Zero_train",numFiles);
zero_test = LoadMassFiles("Zero_test",numFiles);
twelve_train = LoadMassFiles("Zero_train",numFiles);
twelve_test = LoadMassFiles("Zero_test",numFiles);
close all;


% Initialize cookbook
Cookbook = [];

% Concatenate all the codebooks
for i = 1:numFiles
    % add an indicator number to the top of the codebook
    numCodebookVectors = size(zero_train{i}.Codebook,2);
    tempCodebook = [ones(1,numCodebookVectors)*i ; zero_train{i}.Codebook];
    tempCodebookTwo = [ones(1,numCodebookVectors)*i ; twelve_train{i}.Codebook];
    Cookbook = [Cookbook, tempCodebook, tempCodebookTwo];
end
% Cookbook excluding the first row which is the indicator for which set it
% came from 
CookbookWithNoPageNumbers = Cookbook(2:end,:);

% Zero Train and Zero Test
counter = 0;
for i = 1:numFiles
    test1 = zero_test{i}.Codebook;

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
fprintf('Congratulations on testing Zero! \nPercent Correct: %f%%\nNumber Correct: %i\n\n',100*counter/numFiles,counter)


% Twelve Test and Twelve Train
counter = 0;
for i = 1:numFiles
    test1 = twelve_test{i}.Codebook;

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
fprintf('Congratulations on testing Twelve! \nPercent Correct: %f%%\nNumber Correct: %i\n\n',100*counter/numFiles,counter)

