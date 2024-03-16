% GenerateCodebook.m a function file that allows you to generate a codebook
% of centroids based on an inputed training MelCepArray

% % Testing Ground
% numTrainFiles = 1;
% train_objs = LoadMassFiles("train",numTrainFiles);
% 
% % load in the MFCC and define error
% MFCC = train_objs{1}.MelCepstrumArray;
% 

function centroids = GenerateCodebookLoops(MFCC,error,numLoops) 

D0 = 0;
Dk = 9999;
k = 1;
splitted = [];
distanceToCentroid = [];

    % Initialize centroid by starting at the average of all points
    centroids = mean(MFCC,2);
    
    % set the condition for convergence
    % and start loop for calculating centroids
    for u = 1:numLoops
    
        % Step 0: Set Dk to the previous iteration, D0
        D0 = Dk;
    
        % Step 1: Split the centroids using the following loop
        for i = 1:size(centroids,2)
            splitted = [splitted, centroids(:,i).*(1+error), centroids(:,i).*(1-error)];
        end
    
        % Step 2: calculate the distances for all the training points to splits
        for i = 1:size(splitted,2)
            distanceToCentroid = [distanceToCentroid, Distance2MelCeps(MFCC,splitted(:,i))'];
        end
    
        % Step 3: Calculate the minimum indexes corresponding to the
        % closest distances from each split to each frame.
        % calculate the indexes of the MFCC frames closest to each split
        % if an MFFC is closest to a split it is saved as a logical 1
        % Note that our whole column scheme is kinda transposed
        minIndexes = IndexMinArray(distanceToCentroid);
    
        % Step 4: Gravity, move the splits to the average of the closest
        % frames to those centroids based on the indexing array
        % You need to reset centroids here so it can update with the new
        % means given by distance and split vectors
        centroids = [];
        for i = 1:size(minIndexes,2)
            centroids = [centroids, mean(MFCC(:,minIndexes(:,i)),2)];
        end
        % unNAN and unZERO the centroids vectors
        centroids(isnan(centroids)) = 0;
        zero_columns = all(centroids == 0, 1);
        centroids = centroids(:, ~zero_columns);
    
%         figure(1)
%         x = 6;
%         y = 19;
%         scatter(MFCC(x,:),MFCC(y,:),150);
%         hold on;
%         scatter(centroids(x,:),centroids(y,:),50,"filled");
%         hold off;
%         pause(2)
    
    end
end
