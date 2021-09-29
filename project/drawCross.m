function drawCross()
    crossLength = 10;
    crossColor = 0;
    crossWidth = 3;
    crossLines = [-crossLength 0; crossLength 0; 0 -crossLength; 0 crossLength];
    crossLines = transpose(crossLines);
    [wPtr, rect] = Screen('OpenWindow', 0, [255 255 255], [0 0 1024 768]);
    xCenter = rect(3) / 2;
    yCenter = rect(4) / 2;
    Screen('DrawLines', wPtr, crossLines, crossWidth, crossColor, [xCenter yCenter]);
    Screen('Flip', wPtr);
    WaitSecs(5);
    sca;
end
