clear
clc
%% Setting before recording
video = VideoWriter('controlPlots.avi');
fps = 10; % 'frames per a second(fps)' = 'frame rate'
video.FrameRate = fps;
video.Quality = 100;

% functions to draw
a = 1; % starting value
r = 0.5; % rate parameter
x = [0:20];
y_power= a * x.^-r; % power function
y_exp= a * exp(r*-x); % exponential function

% offsets
vertical_offset= 0.05; % distance to move vertically from point on plot
horizontal_offset= 0.50; % distance to move horizontally from point on plot

% 'Power function' text position 
% a point shifted by the offset from point (x(5), y_power(5))
horizontal_power= x(5) + horizontal_offset;
vertical_power= y_power(5) + vertical_offset;

% 'Exponential function' text position 
% a point shifted by the offset from point (x(6), y_exp(6))
horizontal_exp= x(6) + horizontal_offset;
vertical_exp= y_exp(6) + vertical_offset;
%% Records the video
open(video); % open video file
figure(1)
axis([0 20 0 1]); % setting axis limit (x-axis : 0 to 20, y-axis : 0 to 1)
set(gca,'tickdir', 'out', 'box', 'on')
hold on

pauseTime(0.5,video,fps) % pause for 0.5 sec
plot(x, y_power, 'k:') % plot the power function
pauseTime(0.5, video, fps) % pause for 0.5 sec

% draw magenta circle symbols on the power function
for i = 1:length(x)
    plot(x(i), y_power(i),'mo'); % 'm' for magenta(color) 'o' for circle(shape)
    F = getframe(gcf);
    writeVideo(video, F);
end

plot(x, y_exp,'k:'); % plot the exponential function
pauseTime(0.5, video, fps) % pause for 0.5 sec

% draw black diamond symbols on the exponential function
for i = 1:length(x)
    plot(x(i), y_exp(i),'kd'); % 'k' for black(color) 'd' for diamond(shape)
    F = getframe(gcf);
    writeVideo(video, F);
end

% place text labels
text(horizontal_power,vertical_power,'Power function');
text(horizontal_exp,vertical_exp,'Exponential function');
pauseTime(3,video,fps) % last(pause) for 3 sec
close(video); % close video file