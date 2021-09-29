% Part One:  Initialization
Screen('Preference', 'VisualDebugLevel', 1);
sinit = input('Subject''s initials: ', 's');
outfilename = ['SimonDataPTB_' sinit];
Screen('Preference', 'SkipSyncTests', 0);
% [window  Scrnsize]= Screen('OpenWindow', max(Screen('screens')), [255 255 255], [0 0 2*2048/3 2*1440/3]);
% [window  Scrnsize]= Screen('OpenWindow', 0, [255 255 255]);
KbName('UnifyKeyNames');
centerX = Scrnsize(3) / 2;
centerY = Scrnsize(4) / 2;
Screen('TextFont', window, 'Arial');
Screen('TextSize', window, 72);
timeout = 2;
[ttype(1:4).side] = deal('L', 'R', 'L', 'R');
[ttype(1:4).stim] = deal('L', 'L', 'R', 'R');
[ttype(1:4).comp] = deal('C', 'I', 'I', 'C');

% Prepare data fields for each type of trial.
[ttype(1:4).RT] = deal([]);
[ttype(1:4).error] = deal(0);

%get the size of the fixation cross
[bounds] = Screen('TextBounds', window, '+');
fixSizeX = bounds(3) / 2;

%get the size of the stimuli
[bounds] = Screen('TextBounds', window, 'L');
stimSizeX = bounds(3) / 2;
leftStimX = centerX - 400 - stimSizeX;
rightStimX = centerX + 400 - stimSizeX;
ListenChar(2);

% Part Two:  Data Collection
HideCursor

for blocknumber = 1:8

    for typenum = randperm(4);
        WaitSecs(2); %pause at start of trial, then show fixation
        Screen('DrawText', window, '+', centerX - fixSizeX, centerY, [0 0 0]);
        onsetTime1 = Screen('Flip', window);
        %Draw the fixation cross
        Screen('DrawText', window, '+', centerX - fixSizeX, centerY, [0 0 0]);
        %Show the stimulus on the left or right side
        if ttype(typenum).side == 'L'
            Screen('DrawText', window, ttype(typenum).stim, leftStimX, centerY, [0, 0, 0]);
        else
            Screen('DrawText', window, ttype(typenum).stim, rightStimX, centerY, [0, 0, 0]);
        end

        Starttime = Screen('Flip', window, onsetTime1 + 1.0);
        Nowtime = Starttime;
        responseGiven = 0;
        response = 0;
        %collect a response with a timeout
        while (Nowtime < Starttime + timeout & responseGiven == 0)
            %Check for a response
            [keyDown secs keyCode] = KbCheck(-1);

            if (keyDown)
                responseGiven = 1;
                response = KbName(keyCode);
            end

            Nowtime = GetSecs; % check the current time
        end

        thisRT = secs - Starttime; %compute the reaction time

        if (response(1) == 'a') %convert the response into L or R
            thisResp = 'L';
        elseif (response(1) == ';')
            thisResp = 'R';
        else
            thisResp = 'X';
        end

        if ttype(typenum).stim == thisResp
            ttype(typenum).RT = [ttype(typenum).RT thisRT];
        else
            ttype(typenum).error = ttype(typenum).error + 1;
            Beeper;
        end

        Screen('Flip', window);
    end

end

% Part Three:  Cleanup and File save
ShowCursor
ListenChar(0);
save(outfilename, 'ttype');

Screen('CloseAll');
