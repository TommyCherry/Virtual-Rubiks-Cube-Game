function draw3x3grid(xmin, ymin, xsize, ysize, color, gridInstance, colorIndex)
    % Define the grid size
    numRows = 3; % Number of rows
    numCols = 3; % Number of columns
    squareSize = 0.05; % Side length of each square
    
    ax = axes('Position', [xmin, ymin, xsize, ysize]); % position/size for the 3x3 grid
    axis(ax, 'off'); % No axis labels
    
    % Loop through each square
    for row = 1:numRows
        for col = 1:numCols
            % Calculate the bottom-left corner position of each square
            xPos = (col - 1) * squareSize;
            yPos = (numRows - row) * squareSize;
    
            % Draw a square at the specified position
            rectHandle = rectangle('Position', [xPos, yPos, squareSize, squareSize], ...
                      'FaceColor', color, 'EdgeColor', 'k'); % White squares with black borders
            gridInstance.Squares{colorIndex, row, col} = rectHandle;
            xticks([])
            yticks([])
        end
    end
    axis off;
end