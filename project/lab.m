% Clear the workspace
close all;
clear all;
sca;

sinit = input('Subject''s initials: ','s');
filename_resp = ['ResponseData_' sinit];
filename_res = ['Data_' sinit];

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
Screen('Preference', 'SkipSyncTests', 1);
[wPtr, rect] = Screen('OpenWindow',0, [0 0 0], [0 0 1024 768]);

% Flip to clear
Screen('Flip', wPtr);

% Query the frame duration
ifi = Screen('GetFlipInterval', wPtr);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(rect);

% Set the blend funciton for the screen
Screen('BlendFunction', wPtr, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

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
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftShift');
rightKey = KbName('RightShift');

%----------------------------------------------------------------------
%                     Colors in words and RGB
%----------------------------------------------------------------------

% We are going to use three colors for this demo. Red, Green and blue.
wordList = {'빨강', '초록', '파랑', '노랑', '네모', '세모', '타원'};
rgbColors = [1 0 0; 0 1 0; 0 0 1; 0 1 1];

% Make the matrix which will determine our condition combinations
colorMatrix = [sort(repmat([1 2 3 4], 1, 4)); repmat([1 2 3 4], 1, 4)];
wordFigureMatrix = [sort(repmat([1 2 3 4 5 6 7], 1, 3)); repmat([5 6 7], 1, 7)];
condMatrix = [repmat(wordFigureMatrix, 1, 16); repmat(colorMatrix, 1, 21)];

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
    figNum = condMatrixShuffled(2, trial);
    wordcolorNum = condMatrixShuffled(3, trial);
    figcolorNum = condMatrixShuffled(4, trial);
    
    % The color word and the color it is drawn in
    theWord = wordList(wordNum);
    theWordColor = rgbColors(wordcolorNum, :);
    theFigColor = rgbColors(figcolorNum, :);
    
    % Cue to determine whether a response has been made
    respToBeMade = true;
    
    % If this is the first trial we present a start screen and wait for a
    % key-press
    if trial == 1
%         DrawFormattedText(wPtr, 'Name the color \n\n Press Any Key To Begin',...
%             'center', 'center', black);
        Screen('Flip', wPtr);
%         KbStrokeWait(-1);
    end
    
    % Flip again to sync us to the vertical retrace at the same time as
    % drawing our fixation point
    drawFixationCross(wPtr, rect, 10, [255 255 255], 3)
    vbl = Screen('Flip', wPtr);

    % Now we present the isi interval with fixation point minus one frame
    % because we presented the fixation point once already when getting a
    % time stamp
    for frame = 1:isiTimeFrames - 1

        % Draw the fixation point
        drawFixationCross(wPtr, rect, 10, [255 255 255], 3)
        

        % Flip to the screen
        vbl = Screen('Flip', wPtr, vbl + (waitframes - 0.5) * ifi);
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

        % Draw the word and figure
%         DrawFormattedText(wPtr, char(theWord), 'center', 'center', theWordColor);
        if figNum == 5
            drawFrameRect(wPtr, rect, 500, theFigColor, 3);
        elseif figNum == 6
            drawFrameTri(wPtr, rect, 500, theFigColor, 3);
        elseif figNum == 7
            drawFrameOval(wPtr, rect, 500, theFigColor, 3);
        end
        
        % Check the keyboard. The person should press the
        [keyIsDown,secs, keyCode] = KbCheck(-1);
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            return
        elseif keyCode(leftKey)
            response = 0;
            respToBeMade = false;
        elseif keyCode(rightKey)
            response = 1;
            respToBeMade = false;
        end

        % Flip to the screen
        vbl = Screen('Flip', wPtr, vbl + (waitframes - 0.5) * ifi);
    end
    tEnd = GetSecs;
    rt = tEnd - tStart;
    
    % Record the trial data into out data matrix
    respMat(1, trial) = wordNum;
    respMat(2, trial) = figNum;
    respMat(3, trial) = wordcolorNum;
    respMat(4, trial) = figcolorNum;
    respMat(5, trial) = response;
    respMat(6, trial) = rt;
    
end

% End of experiment screen. We clear the screen once they have made their
% response
% DrawFormattedText(wPtr, 'Experiment Finished \n\n Press Any Key To Exit',...
%     'center', 'center', black);
Screen('Flip', wPtr);
% KbStrokeWait(-1);
sca;

caseA = [];
caseB = [];
caseC = [];
caseD = [];
for i = 1:size(respMat, 2)
    meaningMatch = (respMat(1,i) == respMat(2,i)) || (respMat(1,i) == respMat(4,i))
    colorMatch = (respMat(3,i) == respMat(4,i))
    isRepCorrect= (meaningMatch==respMat(5,i))
    if meaningMatch && colorMatch
        caseA = [caseA;isRepCorrect respMat(6,i)];
    elseif meaningMatch && ~colorMatch
        caseB = [caseB;isRepCorrect respMat(6,i)];
    elseif ~meaningMatch && colorMatch
        caseC = [caseC;isRepCorrect respMat(6,i)];
    elseif ~meaningMatch && ~colorMatch
        caseD = [caseD;isRepCorrect respMat(6,i)];
	end
end

% Part Three:  Cleanup and File save
ShowCursor
ListenChar(0);

resMat = [caseA caseB caseC caseD]
save(filename_resp,'respMat');
save(filename_res,'resMat');

Screen('CloseAll');