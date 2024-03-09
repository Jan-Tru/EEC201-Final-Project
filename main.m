% main.m file for the 201 audio recognition project
% this one's gonna be hella fun

%% Testing section for all the Methods of WavFileObj
clc;

numTestFiles = 8;
numTrainFiles = 8;

test_objs = LoadMassFiles("test",numTestFiles);
train_objs = LoadMassFiles("train",numTrainFiles);



% zero_train = LoadMassFiles("Zero_train",numFiles);
% zero_test = LoadMassFiles("Zero_test",numFiles);
% twelve_train = LoadMassFiles("Zero_train",numFiles);
% twelve_test = LoadMassFiles("Zero_test",numFiles);

% MelCA1 = zero_train{1}.MelCepstrumArray;
% MelCA2 = zero_train{2}.MelCepstrumArray;
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
disp(percentCorrect*100);


