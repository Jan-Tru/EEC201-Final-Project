% TestingGround.m file for the 201 audio recognition project
% this one's gonna be hella fun

%% Testing section for all the Methods of WavFileObj
clc;

numFiles = 19;
zero_train = LoadMassFiles("Zero_train",numFiles);
%zero_test = LoadMassFiles("Zero_test",numFiles);

% zero_train{1}.PlotWaveform
 zero_train{18}.Play
 zero_train{19}.Play
% zero_train{1}.FilePath
% zero_train{1}.SampleRate
% zero_train{1}.FrameArray
% zero_train{1}.MelPointAmouny
% zero_train{1}.MelCepstrumArray
% size(zero_train{1}.MelWrapArray)
% zero_train{1}.PlotFFTFrame(2)
% size(zero_train{1}.FFTArray,2)
% zero_train{1}.PlotSpectrogram
% zero_train{1}.PlotMelArray