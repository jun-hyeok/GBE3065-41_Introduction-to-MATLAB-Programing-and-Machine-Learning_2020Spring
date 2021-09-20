%% Pause the current graphic for some seconds and keep recording
function pauseTime(time, video_object, fps)

    for iFrame = 1:fps * time % fps * time = 'frames to record'
        frame = getframe(gcf);
        writeVideo(video_object, frame);
    end

end
