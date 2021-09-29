function drawText(wPtr, rect, text, fontsize, color)
    [xCenter, yCenter] = RectCenter(rect);
    textRect = Screen('TextBounds', wPtr, text);
    textWidth = textRect(3);
    textHeight = textRect(4);
    textX = xCenter - textWidth / 2;
    textY = yCenter - textHeight / 2;
    Screen('TextFont', wPtr, 'Times');
    Screen('TextSize', wPtr, fontsize);
    Screen('TextStyle', wPtr, 1);
    Screen('DrawText', wPtr, text, textX, textY, color);
    Screen('Flip', wPtr)
end
