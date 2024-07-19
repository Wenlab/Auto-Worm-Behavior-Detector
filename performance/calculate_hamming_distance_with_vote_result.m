function hamming_distances_to_plurality_vote = calculate_hamming_distance_with_vote_result(human_label_all, human_label)

% CALCULATE_HAMMING_DISTANCES Calculate Hamming distances between each
% column of human_label_all and human_label.
%
% INPUTS:
%   human_label_all - N x 5 matrix
%   human_label - N x 1 vector
%
% OUTPUT:
%   hamming_distances - 1 x 5 vector of Hamming distances

% Ensure human_label is a column vector
if isrow(human_label)
    human_label = human_label';
end

% Calculate Hamming distances
hamming_distances_to_plurality_vote = sum(human_label_all ~= human_label, 1);
end