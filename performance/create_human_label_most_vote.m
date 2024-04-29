function human_label = create_human_label_most_vote(human_label_all)

% Calculate the mode for each row
human_label = mode(human_label_all, 2);

end