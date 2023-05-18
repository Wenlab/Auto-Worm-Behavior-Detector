% Initialize variables
filename = 'animation.gif';  % Output GIF file name
delay = 0.1;                % Delay between frames (in seconds)

% Create a new figure for the GIF animation
gifFig = figure();

for i = 1:100
    % Load figure i
    figName = sprintf('fig\figure%d.fig', i);
    open(figName);
    
    % Capture the current figure as an image
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    
    % Write the image to the GIF file
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', delay);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delay);
    end
    
    % Close the figure
    close(figName);
end

% Close the GIF animation figure
close(gifFig);