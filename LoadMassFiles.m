% Load Train Files
% A simple function called from main which loads all the Train Files 

function wavFileObjCellArray = LoadMassFiles(prefix, numIterations)
    wavFileObjCellArray = cell(1, numIterations);
    for i = 1:numIterations
        file_path = sprintf('Training_Audio/%s%d.wav', prefix, i);
        if exist(file_path, 'file')
            wavFileObjCellArray{i} = WavFileObj(file_path);
            wavFileObjCellArray{i}.ID = i;
        else
            fprintf('File %s not found.\n', file_path);
        end
    end
end

