function BlendShapes()
    [a, b, c] = KbWait(-1);
    dk = find(c);
    DisableKeysForKbCheck(dk);
    Screen('Preference', 'SkipSyncTests', 2);
    [wPtr, rect] = Screen('OpenWindow', 0, [128 128 128], [0 0 2560/2 1440/2]);
    Screen('BlendFunction', wPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    color1 = [0 255 0 255];
    color2 = [0 0 255 100];
    Screen('FillRect', wPtr, color1, [300 300 400 400]);
    Screen('FillRect', wPtr, color2, [350 350 450 450]);
    Screen('Flip', wPtr);
    KbWait();
    clear Screen;
end
