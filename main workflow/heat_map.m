% Plot the heat map using imagesc
matrix = frame(:,:,1);
imagesc(matrix);
colormap('hot'); % Set the color map (you can choose any colormap you prefer)
colorbar; % Display the colorbar

% Set axis labels
xlabel('Columns');
ylabel('Rows');

% Set the title
title('Heat Map of Matrix');

% Adjust the aspect ratio
axis equal;

% Display the plot