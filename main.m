% main.m file for the 201 audio recognition project
% this one's gonna be hella fun

%% Testing section for all the Methods of WavFileObj
clc;

numFiles = 19;
zero_train = LoadMassFiles("Zero_train",numFiles);
zero_test = LoadMassFiles("Zero_test",numFiles);
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

a = zero_train{1}.FrameArray
% format short;
% for test input audio objects, k
% for k = 1:19
%     [minDistance, minIndex] = TestTrainDistanceFinder(k,zero_test,zero_train);
% end



