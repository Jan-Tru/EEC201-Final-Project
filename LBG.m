
function [codebook] = LBG(input_matrix,k)
% What did they call President LBJ after January 22, 1973?
% Lyndon B. Gone-son 
% LBG.m
% The Luzo C Gray Algothriym is pretty straight foward after watching some indian
% tutorials online

% Goal: I want this to be a function.
% it will take in a MelCATrain_X array
% it will produce a codebook for this array
% Input: MelCATrain_X
% Remember that this function takes in a MelCA and makes a codebook for it
% C is the cluster assignment

%input_matrix = Input_Array;
%k = 10;

clc;
num_runs = 100;

% matrix init
idx_all = cell(num_runs, 1);
obj_values = zeros(num_runs, 1);

opts = statset('Display', 'off');

for i = 1:num_runs
    [idx, C, sumd, D] = kmeans(input_matrix, k, 'Start', 'plus', 'Options', opts);
    idx_all{i} = idx;
    obj_values(i) = sum(sumd);
end

% Select the clustering result with the best overall performance
[~, best_run] = min(obj_values);
idx = idx_all{best_run};
% fprintf('%d \n',idx )
% fprintf('best_run = %d\n',best_run')

C_copy = C;

% I have my seedling centroid.... You know I had to double it
size(C)
err = 0.001;
C1 = DoubleTheCentroids(C, err);
size(C1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num_iterations = 500; % Define the maximum number of iterations

% Initialize the loop variables


% Initialize the matrix with zeros
C_old = zeros(size(C1));

% Define the tolerance for convergence
tolerance = 0.1;
fprintf('Anudda one')
% Initialize a structure to store centroid variables
centroid_struct = struct();

% Iterate until convergence or maximum number of iterations
while true

    % Create a copy of the current centroids
    Cnew = C;
    fprintf('\n Anudda one \n')
    % Update centroids for each iteration
    for i = 1:num_iterations
        % Double the centroids and store them in the old centroid positions
        C_new = DoubleTheCentroids(C1, err);
         fprintf('\n Hi1 \n')   
        % Store the updated centroids in the centroid structure
       % centroid_struct.(['C' num2str(i)]) = C_new;
         fprintf('\n Hi2 \n')   
    end

    % Update the centroids from the previous iteration
    C_old = C_new;

    norm(C_old - C_new)
         fprintf('\n Hi3 \n')   
    % Check for convergence
    if norm(C_old - C_new) < tolerance
        fprintf('\n JACKPOT!!! \n')
       break; % Break the loop if convergence criterion is met

    end


    
end
 
codebook = C_new;











end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This block plots the clusters and centeroids

% % Example data matrix
% X = input_matrix;
% 
% % Perform PCA to reduce dimensionality to 3 dimensions
% coeff = pca(X);
% X_pca = X * coeff(:, 1:3);
% 
% % Example centroid array
% centroids = C_new;
% 
% % Plot the reduced-dimensional data and centroids in 3D
% scatter3(X_pca(:, 1), X_pca(:, 2), X_pca(:, 3), 50, 'filled');
% hold on;
% scatter3(centroids(:, 1), centroids(:, 2), centroids(:, 3), 200, 'r', 'x');
% hold off;
%          fprintf('\n I need to ploop \n')  
% xlabel('Principal Component 1');
% ylabel('Principal Component 2');
% zlabel('Principal Component 3');
% title('PCA Visualization of High-Dimensional Data with Centroids (3D)');
% legend('Data Points', 'Centroids', 'Location', 'best');
% 
%          fprintf('\n I plooped \n')  
%%