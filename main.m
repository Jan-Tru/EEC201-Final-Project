%% Testing section for all the Methods of WavFileObj
clc;

numTestFiles = 8;
numTrainFiles = 8;
numFiles = 8;
epsilon = 0.01;
k = 10;             % amt of times kmean() runs in LBG.m


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


% Don't mind me; just cookin' up some codebooks
for i = 1:numFiles
        str = sprintf('codebook%d = LBG(MelCA_Train%d, %d)', i,i, k);
        eval(str);
end























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
