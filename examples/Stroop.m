% Clear the workspace
close all;
clear all;
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);

% Open the screen
Screen('Preference', 'SkipSyncTests', 0);
[window, windowRect] = Screen('OpenWindow', 0, [0 0 0], [0 0 1024 768]);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 60);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Interstimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);

% Numer of frames to wait before re-drawing
waitframes = 1;

%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
downKey = KbName('DownArrow');

%----------------------------------------------------------------------
%                     Colors in words and RGB
%----------------------------------------------------------------------

% We are going to use three colors for this demo. Red, Green and blue.
wordList = {'??????', '??????', '??????', '??????'};
rgbColors = [1 0 0; 0 1 0; 0 0 1; 0 1 1];

% Make the matrix which will determine our condition combinations
condMatrixBase = [sort(repmat([1 2 3 4], 1, 4)); repmat([1 2 3 4], 1, 4)];

% Number of trials per condition. We set this to one for this demo, to give
% us a total of 9 trials.
trialsPerCondition = 4;

% Duplicate the condition matrix to get the full number of trials
condMatrix = repmat(condMatrixBase, 1, trialsPerCondition);

% Get the size of the matrix
[~, numTrials] = size(condMatrix);

% Randomise the conditions
shuffler = randperm(numTrials);
condMatrixShuffled = condMatrix(:, shuffler);

%----------------------------------------------------------------------
%                     Make a response matrix
%----------------------------------------------------------------------

% This is a four row matrix the first row will record the word we present,
% the second row the color the word it written in, the third row the key
% they respond with and the final row the time they took to make there response.
respMat = nan(6, numTrials);

%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
for trial = 1:numTrials

    % Word and color number
    wordNum = condMatrixShuffled(1, trial);
    colorNum = condMatrixShuffled(2, trial);

    % The color word and the color it is drawn in
    theWord = wordList(wordNum);
    theColor = rgbColors(colorNum, :);

    % Cue to determine whether a response has been made
    respToBeMade = true;

    % If this is the first trial we present a start screen and wait for a
    % key-press
    if trial == 1
        %         DrawFormattedText(window, 'Name the color \n\n Press Any Key To Begin',...
            %             'center', 'center', black);
        Screen('Flip', window);
        KbStrokeWait(-1);
    end

    % Flip again to sync us to the vertical retrace at the same time as
    % drawing our fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    vbl = Screen('Flip', window);

    % Now we present the isi interval with fixation point minus one frame
    % because we presented the fixation point once already when getting a
    % time stamp
    for frame = 1:isiTimeFrames - 1

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end

    % Now present the word in continuous loops until the person presses a
    % key to respond. We take a time stamp before and after to calculate
    % our reaction time. We could do this directly with the vbl time stamps,
    % but for the purposes of this introductory demo we will use GetSecs.
    %
    % The person should be asked to respond to either the written word or
    % the color the word is written in. They make thier response with the
    % three arrow key. They should press "Left" for "Red", "Down" for
    % "Green" and "Right" for "Blue".
    tStart = GetSecs;

    while respToBeMade == true

        % Draw the word
        %         DrawFormattedText(window, char(theWord), 'center', 'center', theColor);

        % Check the keyboard. The person should press the
        [keyIsDown, secs, keyCode] = KbCheck(-1);

        if keyCode(escapeKey)
            ShowCursor;
            sca;
            return
        elseif keyCode(leftKey)
            response = 1;
            respToBeMade = false;
        elseif keyCode(downKey)
            response = 2;
            respToBeMade = false;
        elseif keyCode(rightKey)
            response = 3;
            respToBeMade = false;
        end

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end

    tEnd = GetSecs;
    rt = tEnd - tStart;

    % Record the trial data into out data matrix
    respMat(1, trial) = wordNum;
    respMat(2, trial) = colorNum;
    respMat(3, trial) = response;
    respMat(4, trial) = rt;

end

% End of experiment screen. We clear the screen once they have made their
% response
% DrawFormattedText(window, 'Experiment Finished \n\n Press Any Key To Exit',...
    %     'center', 'center', black);
Screen('Flip', window);
KbStrokeWait(-1);
sca;

congR = [];
inCongR = [];

for i = 1:size(respMat, 2)

    if respMat(2, i) == respMat(3, i) & respMat(1, i) == respMat(2, i)
        congR = [congR; respMat(4, i)];
    elseif respMat(2, i) == respMat(3, i) & respMat(1, i) ~= respMat(2, i)
        inCongR = [inCongR; respMat(4, i)];
    end

end

clf;
scatter([1 2], [mean(congR) mean(inCongR)], 'ro', 'filled');
hold on
errorbar([1 2], [mean(congR) mean(inCongR)], [std(congR) / sqrt(length(congR) - 1) std(inCongR) / sqrt(length(inCongR) - 1)]);
set(gca, 'xlim', [0 3], 'xtick', [1 2], 'tickdir', 'out', 'xticklabel', {'Match', 'Mismatch'});
ylabel('Response Time (s)');
