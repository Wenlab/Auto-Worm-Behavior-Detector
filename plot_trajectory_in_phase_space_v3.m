function plot_trajectory_in_phase_space_v3(curvature_of_centerline_all, eigen_basis, gifFilename)
    figure;
    scatterPlot = scatter(0, 0);
    xlabel('a_1');
    ylabel('a_2');
    title('trajectory in phase space');
    axis equal;
    lim = 0.65;
    xlim([-lim +lim]);
    ylim([-lim +lim]);
    
    % Initialize the animated line
    animatedLinePlot = animatedline('Color', 'b');
    
    % Create a GIF writer object
    gifWriter = [];
    
    % Iterate through the trajectory points
    for i = 1:size(curvature_of_centerline_all, 1)
        trajectoryPoint = curvature_of_centerline_all(i, :) * eigen_basis(:, 1:2);
        
        % Add the point to the animated line
        addpoints(animatedLinePlot, trajectoryPoint(1), trajectoryPoint(2));
        
        % Update the scatter plot
        set(scatterPlot, 'XData', trajectoryPoint(1), 'YData', trajectoryPoint(2));
        
        % Pause to control the animation speed (adjust as needed)
        pause(0.01);
        
        % Refresh the figure window
        drawnow;
        
        % Capture the current frame
        frame = getframe(gcf);
        
        % Convert the frame to an indexed image
        indexedFrame = frame2im(frame);
        [indexedFrame, colormap] = rgb2ind(indexedFrame, 256);
        
        % Initialize the GIF writer object if it doesn't exist
        if isempty(gifWriter)
            % Create the GIF file
            imwrite(indexedFrame, colormap, gifFilename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
            gifWriter = true;
        else
            % Append the frame to the GIF file
            imwrite(indexedFrame, colormap, gifFilename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
    end
end
