function visualize_by_tSNE(Y_expert)
figure;
scatter(Y_expert(:,1), Y_expert(:,2), 100, 'filled');
text(Y_expert(:,1), Y_expert(:,2), arrayfun(@num2str, 1:size(Y_expert, 1), 'UniformOutput', false), 'VerticalAlignment','bottom', 'HorizontalAlignment','right');
title('2D t-SNE Visualization of Human Experts');
xlabel('Dimension 1');
ylabel('Dimension 2');
end