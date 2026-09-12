% This is the main file, so to run the program, all you have to do is run
% this file with all the other files opened up in the same directory.
%
% You can click on the start button to scramble the cube, but you will have
% to click somewhere else on the screen right after before you can start
% typing the keybinds.
%
% The keybinds I have implemented are as follows:
%
% spacebar to scramble the cube up (can be used as an alternative to
% pressing the button at the very beginning)
%
% f and j for turning the upper layer CCW and CW respectively
% e and d for turning the left layer CCW and CW respectively
% k and i for turning the right layer CCW and CW respectively
% g and h for turning the front layer CCW and CW respectively
% o and w for turning the back layer CCW and CW respectively
% l and s for turning the down layer CCW and CW respectively
%
% enter to stop the timer


%% INITIALIZATION

% Initialize the user input storage
userInput = '';


%% TIMER

% Initialize the timer object
t = timer;

t.Period = 0.01;              % Update every 0.01 seconds
t.ExecutionMode = 'fixedRate'; % Execute at fixed intervals
t.TasksToExecute = Inf;        % Run indefinitely
t.StartDelay = 0;


%% START TIME

% Placeholder start time initialization
% (will be changed at other parts of the program as it runs)
startInstance = startTime();


%% CUBE GRID

% Used for storing grid colors as variables which can be manipulated
% with keybinds
gridInstance = grid();

gridInstance.Squares = cell(6, 3, 3);


%% FIGURE

% 100s represent coordinates of the bottom-left corner of figure window
figHandle = figure( ...
    'Position', [100, 100, 800, 800], ...
    'KeyPressFcn', @(src, event) ...
        keyPressCallback(src, event, gridInstance, t, startInstance));


%% DRAW CUBE

% Call function to draw 3x3 grid, repeat for each face of the cube

% Left
% RGB code is used since 'orange' isn't built into MATLAB
draw3x3grid( ...
    0.05, 0.35, 0.1, 0.1, ...
    [0.9290 0.6940 0.1250], ...
    gridInstance, 1);

% Front
draw3x3grid( ...
    0.17, 0.35, 0.1, 0.1, ...
    'green', ...
    gridInstance, 2);

% Right
draw3x3grid( ...
    0.29, 0.35, 0.1, 0.1, ...
    'red', ...
    gridInstance, 3);

% Back
draw3x3grid( ...
    0.41, 0.35, 0.1, 0.1, ...
    'blue', ...
    gridInstance, 4);

% Bottom
draw3x3grid( ...
    0.17, 0.23, 0.1, 0.1, ...
    'yellow', ...
    gridInstance, 5);

% Top
draw3x3grid( ...
    0.17, 0.47, 0.1, 0.1, ...
    'white', ...
    gridInstance, 6);


%% SCRAMBLE BUTTON

% Add a scramble button to the figure
btn = uicontrol( ...
    'Style', 'pushbutton', ...
    'String', 'Click to scramble', ...
    'Position', [500, 150, 100, 50], ...
    'Callback', @(src, event) ...
        buttonCallback(gridInstance, t, startInstance), ...
    'BackgroundColor', [0.6, 0.8, 1]);


%% TIMER DISPLAY

% Add a uicontrol to display the timer
timerText = uicontrol( ...
    'Parent', figHandle, ...
    'Style', 'text', ...
    'String', '00:00:00', ...
    'FontSize', 42, ...
    'FontWeight', 'bold', ...
    'Units', 'normalized', ...
    'Position', [0.3, 0.5, 0.4, 0.2]);


%% TIMER CALLBACK

% IMPORTANT:
% TimerFcn must be assigned before the program reaches the local function
% definitions below. Otherwise, start(t) will fail because the timer does
% not have a callback function.

t.TimerFcn = @(~, ~) updateTimer(timerText, startInstance);


%% FUNCTIONS


% ---------------------------------------------------------
% Button callback function
% ---------------------------------------------------------

function buttonCallback(gridInstance, t, startInstance)

    % Define an array for possible relevant move inputs
    moves = ['s', 'd', 'f', 'g', 'h', 'j', ...
             'k', 'l', 'w', 'e', 'i', 'o'];

    % Perform 20 random moves to scramble the cube
    for i = 1:20

        % Generate a random permutation and pick the first index
        randomIndex = randperm(length(moves), 1);

        % Get the corresponding move
        randomEntry = moves(randomIndex);

        % Do a random turn based on the selected move
        turns(randomEntry, gridInstance, t, startInstance);

    end

end


% ---------------------------------------------------------
% Key press callback function
% ---------------------------------------------------------

function keyPressCallback(~, event, gridInstance, t, startInstance)

    % Call turns function whenever a valid key is inputted/pressed
    if isscalar(event.Key) || ...
            strcmp(event.Key, 'space') || ...
            strcmp(event.Key, 'return')

        % Check for single-character keys, spacebar, or enter
        turns(event.Key, gridInstance, t, startInstance);

    end

end


% ---------------------------------------------------------
% Timer update function
% ---------------------------------------------------------

function updateTimer(timerText, startInstance)

    % Calculate elapsed time
    elapsedTime = datetime('now') - startInstance.start;

    % Convert elapsed time to a display string
    elapsedStr = datestr(elapsedTime, 'SS.FFF');

    % Update the timer display
    timerText.String = elapsedStr;

end