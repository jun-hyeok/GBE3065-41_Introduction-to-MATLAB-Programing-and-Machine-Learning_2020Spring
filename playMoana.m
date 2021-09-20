function playMoana()

    toTime = inf;
    soundvolume = 1;

    pMovie = [pwd '/Moana.mp4'];

    Screen('Preference', 'SkipSyncTests', 1);

    [wPtr, rect] = Screen('OpenWindow', 0, 0);

    Screen('BlendFunction', wPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    xCenter = rect(3) / 2;
    yCenter = rect(4) / 2;

    [movie, dur, fps, width, height] = Screen('OpenMovie', wPtr, pMovie);

    Screen('PlayMovie', movie, 1, 0, soundvolume);

    t = GetSecs();
    t_curr = GetSecs();

    [catData, mp, alpha_cat] = imread('cat.png');
    catTexture = Screen('MakeTexture', wPtr, catData);
    catData(:, :, 4) = alpha_cat / 2;

    catTexture_tp = Screen('MakeTexture', wPtr, catData);

    [imHeight_cat imWidth_cat colorChannels] = size(catData);

    catRect1 = [xCenter - width / 2 yCenter - height / 2 xCenter - width / 2 + imWidth_cat / 4 yCenter - height / 2 + imHeight_cat / 4];
    catRect2 = [xCenter + width / 2 - imWidth_cat / 4 yCenter - height / 2 xCenter + width / 2 yCenter - height / 2 + imHeight_cat / 4];
    % move up and down (positions in the y-direction changes)
    moveRect = [0 (height - imHeight_cat / 4) * (1 - cos(t_curr - t - 40)) / 2 0 (height - imHeight_cat / 4) * (1 - cos(t_curr - t - 40)) / 2];

    while t < toTime
        tex = Screen('GetMovieImage', wPtr, movie);

        if tex <= 0
            break;
        end

        Screen('DrawTexture', wPtr, tex, [], [xCenter - width / 2 yCenter - height / 2 xCenter + width / 2 yCenter + height / 2]);

        if t_curr > t + 10 & t_curr <= t + 20
            drawFixationCross(wPtr, rect, 15, [255], 4)
        elseif t_curr > t + 20 & t_curr <= t + 30
            drawFixationCross(wPtr, rect, 15, [255], 4)
            Screen('DrawTexture', wPtr, catTexture, [], catRect1);
            Screen('DrawTexture', wPtr, catTexture, [], catRect2);
        elseif t_curr > t + 30 & t_curr <= t + 40
            drawFixationCross(wPtr, rect, 15, [255], 4)
            Screen('DrawTexture', wPtr, catTexture_tp, [], catRect1);
            Screen('DrawTexture', wPtr, catTexture_tp, [], catRect2);
            % over 40 sec
        elseif t_curr > t + 40
            drawFixationCross(wPtr, rect, 15, [255], 4)
            Screen('DrawTexture', wPtr, catTexture, [], catRect1 + moveRect);
            Screen('DrawTexture', wPtr, catTexture, [], catRect2 + moveRect);
        end

        t_curr = Screen('Flip', wPtr);
        Screen('Close', tex);
    end

    Screen('PlayMovie', movie, 0);
    Screen('CloseMovie', movie);
    sca;
end
