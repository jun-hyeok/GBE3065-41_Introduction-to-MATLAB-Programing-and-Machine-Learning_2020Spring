function drawFrameOval(wPtr, rect, length, color, width)
    [xCenter, yCenter] = RectCenter(rect);
    rectLeft = xCenter - length / 2;
    rectTop = yCenter - length / 2;
    rectRight = xCenter + length / 2;
    rectBottom = yCenter + length / 2;
    position = [rectLeft rectTop rectRight rectBottom]
    Screen('FrameOval', wPtr, color, position, width)
end
