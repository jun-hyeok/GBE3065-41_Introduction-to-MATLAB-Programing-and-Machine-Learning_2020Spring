function drawFrameTri(wPtr, rect, length, color, width)
    [xCenter, yCenter] = RectCenter(rect);
    xCoord = [xCenter - length / 2, xCenter, xCenter + length / 2]';
    yCoord = [yCenter + length / sqrt(12), yCenter - length / sqrt(3), yCenter + length / sqrt(12)]';
    yShift = [length / sqrt(75) length / sqrt(75) length / sqrt(75)]';
    pointList = [xCoord yCoord + yShift];
    Screen('FramePoly', wPtr, color, pointList, width)
end
