function getKeypress2
    Screen('Preference', 'SkipSyncTests', 1);
    WaitSecs(.5);
    startTime = GetSecs();
    keyIsDown = 0;
    [wPtr, rect] = Screen('OpenWindow', max(Screen('Screens')));
    bgColor = 255;
    Screen('FillRect', wPtr, bgColor);
    Screen('Flip', wPtr);
    increment = -1;

    while ~keyIsDown
        [keyIsDown, pressedSecs, keyCode] = KbCheck(-1);
        bgColor = bgColor + increment

        if bgColor <= 0 || bgColor >= 255
            increment = -increment;
        end

        Screen('FillRect', wPtr, bgColor);
        Screen('Flip', wPtr);
    end

    pressedKey = KbName (find(keyCode));
    reactionTime = pressedSecs - startTime;

    fprintf('\nKey %s was pressed at %.4f seconds\n\n', pressedKey, reactionTime);
end
