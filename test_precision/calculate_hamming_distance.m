function hamming_distances = calculate_hamming_distance(human_label_all)

% Assuming human_label_all is your N x 4 matrix
N = size(human_label_all, 1); % Number of rows
num_cols = size(human_label_all, 2); % Should be 4 in your case

% Initialize a matrix to store the Hamming distances
hamming_distances = zeros(num_cols, num_cols);

% Calculate the Hamming distance for each pair of columns
for i = 1:num_cols
    for j = i+1:num_cols
        % Calculate the Hamming distance between columns i and j
        hamming_distances(i, j) = sum(human_label_all(:, i) ~= human_label_all(:, j));
    end
end

% Since the Hamming distance is symmetric, copy the upper triangle to the lower triangle
hamming_distances = hamming_distances + hamming_distances.';

% plot
figure;
imagesc(hamming_distances);
colormap(parula)
colorbar;
axis square;
xlabel('Human Expert');
ylabel('Human Expert');
title('Pairwise Hamming Distances between Human Experts');

end