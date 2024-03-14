function [codebook] = LBG(input_matrix, err)
    %clc;

    % idx_all = cell(num_runs, 1);
    % obj_values = zeros(num_runs, 1);
    % 
    % opts = statset('Display', 'off');
    % for i = 1:num_runs
    %     [idx, C, sumd, ~] = kmeans(input_matrix, k, 'Start', 'plus', 'Options', opts);
    %     idx_all{i} = idx;
    %     obj_values(i) = sum(sumd);
    % end
    % 
    % % Select the clustering result with the best overall performance
    % [~, best_run] = min(obj_values);
    % idx = idx_all{best_run};

    % input_matrix = MelCA_Train8;
    % err = 0.01;

    C = mean(input_matrix,2); % Initialize centroids with the mean of all data points

    max_iterations = 500;       % Define the maximum number of iterations
    epsilon = 0.01;           % Define the convergence threshold

    % Initialize distortion
    D_old = Inf;

    % Iterate until convergence or maximum number of iterations
    for iter = 1:max_iterations
        % Compute distortion
        D = 0;
        for i = 1:size(input_matrix, 1)
            % Find the closest centroid to each data point
           
            distances = sum((input_matrix(i, :) - C).^2, 2);
            [~, idx] = min(distances);
            % Add the squared distance to the distortion
            D = D + sum((input_matrix(i, :) - C(idx, :)).^2);
        end

        % Check for convergence
        %format long
        %converg = abs(D_old - D) / D 

        if abs(D_old - D) / D < epsilon
            fprintf('\n Converged!!! \n');
            break;
        end

        % Update distortion for next iteration
        D_old = D;

        % Update centroids for next iteration
        C = DoubleTheCentroids(C, err);
    end

    codebook = C;
end


% 
% %function [codebook] = LBG(input_matrix,k, err, num_runs)
% % What did they call President LBJ after January 22, 1973?
% % Lyndon B. Gone-son 
% % LBG.m
% % The Luzo C Gray Algothriym is pretty straight foward after watching some indian
% % tutorials online
% 
% % Goal: I want this to be a function.
% % it will take in a MelCATrain_X array
% % it will produce a codebook for this array
% % Input: MelCATrain_X
% % Remember that this function takes in a MelCA and makes a codebook for it
% % C is the cluster assignment
% clc;
% 
%  input_matrix = MelCA_Train6;
%  k = 19;
%  err = 0.00000001;
%  num_runs = 1;
% 
% idx_all = cell(num_runs, 1);
% obj_values = zeros(num_runs, 1);
% 
% opts = statset('Display', 'off');
% for i = 1:num_runs
%     [idx, C, sumd, D] = kmeans(input_matrix, k, 'Start', 'plus', 'Options', opts);
%     idx_all{i} = idx;
%     obj_values(i) = sum(sumd);
% end
% 
% % Select the clustering result with the best overall performance
% [~, best_run] = min(obj_values);
% idx = idx_all{best_run};
% % fprintf('%d \n',idx )
% % fprintf('best_run = %d\n',best_run')
% 
% C_store = C;
% 
% % I have my seedling centroid.... and You know I had to double it
% %size(C)
% %err = 0.001;
% %C1 = DoubleTheCentroids(C, err);
% %size(C1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% max_iterations = 500;               % Define the maximum number of iterations
% tolerance = 0.01;               % Define the tolerance for convergence
% fprintf('Anudda one')
% 
% % Initialize distortion
% D_old = Inf; % Set initial distortion to infinity
% 
% % Iterate until convergence or maximum number of iterations
% for iter = 1:max_iterations
% 
%     % Compute distortion (squared error distortion)
%     D = 0; % Initialize distortion for this iteration
%     for i = 1:size(input_matrix, 1)
%         % Find the closest centroid to each data point
%         distances = sum((input_matrix(i, :) - C).^2, 2);
%         [dist, idx] = min(distances);
%         % Add the squared distance to the distortion
%         D = D + sum((input_matrix(i, :) - C(idx, :)).^2);
% 
%     end
% 
% 
% 
%     % Check for convergence
%     if (D_old - D) / D < epsilon
%         fprintf('\n Converged!!! \n')
%         break;
%     end
% 
%     % Update distortion for next iteration
%     D_old = D;
% 
%     % Update centroids for next iteration
%     C = DoubleTheCentroids(C, err);
% end
% 
% 
% codebook = C;
% 
% %end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% This block plots the clusters and centeroids
% 
% 
% X = input_matrix;
% centroids = C;
% 
% % Perform PCA to reduce dimensionality to 3 dimensions
% coeff = pca(X);
% X_pca = X * coeff(:, 1:3);
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
%          fprintf('\n I plooped \n')  
% %%