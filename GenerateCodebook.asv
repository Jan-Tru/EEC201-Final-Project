% GenerateCodebook.m a function file that allows you to generate a codebook
% of centroids based on an inputed training MelCepArray
numTrainFiles = 1;
train_objs = LoadMassFiles("train",numTrainFiles);

% Step 0, load in the MFCC and define error
    MFCC1 = train_objs{1}.MelCepstrumArray;
    error = 0.01;

% Step 1, average all vectors, should leave 19x1
    centroid1 = mean(MFCC1,2);

% Step 2, split the centroid by multiplying by error plus the average along
    % the diagonal
    centroid2 = [centroid1.*(1+error) centroid1.*(1-error)];
    
    % Then for each vector in centroid2 we need to move them to the average
    % of the closest vectors in MFCC1 to each vector
    
    distanceToCentroid21 = Distance2MelCeps(MFCC1,centroid2(:,1));
    distanceToCentroid22 = Distance2MelCeps(MFCC1,centroid2(:,2));
    indexFor1 = distanceToCentroid21 > distanceToCentroid22;
    indexFor2 = ~indexFor1;
    
    centroid2 = [mean(MFCC1(:,indexFor1),2), mean(MFCC1(:,indexFor2),2)];
    
    % % Test plot, verrified working
    % scatter(MFCC1(1,:),MFCC1(2,:));
    % hold on;
    % scatter(centroid2(1,:),centroid2(2,:));
    % hold off;

%Step 3, split and average again
    len = length(MFCC1);

    alt = generate_alternating_array(len);

    centroid3 = [];
    distanceToCentroid3 = [];

    % split the centroids
    for i = 1:size(centroid2,2)
        centroid3 = [centroid3, centroid2(:,i).*(alt).*(1+error), centroid2(:,i).*(alt).*(1-error)];
    end
    
    % calculate the distances for all the training points to splits
    for i = 1:size(centroid3,2)
        distanceToCentroid3 = [distanceToCentroid3, Distance2MelCeps(MFCC1,centroid3(:,i))'];
    end
  
    distanceToCentroid3;

    minIndexes = IndexMinArray(distanceToCentroid3);

    % Test plot, verrified working
    scatter(MFCC1(1,:),MFCC1(2,:));
    hold on;
    scatter(centroid3(1,:),centroid3(2,:));
    hold off;


