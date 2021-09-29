clear
clc
load('eyeData.mat');
R = @(deg) [cos(pi*deg/180) -sin(pi*deg/180) ; sin(pi*deg/180) cos(pi*deg/180)];
new90EyeH = [];
new90EyeV = [];
new180EyeH = [];
new180EyeV = [];

for i = 1:size(hComp, 1)
    currEye = [hComp(i, :) ; vComp(i, :)];
    rotEye = R(90)*currEye;
    new90EyeH = [new90EyeH ; rotEye(1, :)];
    new90EyeV = [new90EyeV ; rotEye(2, :)];
end

for i = 1:size(hComp, 1)
    currEye = [hComp(i, :) ; vComp(i, :)];
    rotEye = R(-180)*currEye;
    new180EyeH = [new180EyeH ; rotEye(1, :)];
    new180EyeV = [new180EyeV ; rotEye(2, :)];
end

plot(transpose(hComp), transpose(vComp), 'k');
hold on
set(gca, 'xlim', [-12 12], 'ylim', [-12 12], 'tickdir', 'out');
plot([-12 12], [0 0], 'k:');
plot([0 0], [-12 12], 'k:');
plot(transpose(new90EyeH), transpose(new90EyeV), 'b');
plot(transpose(new180EyeH), transpose(new180EyeV), 'g');
%%
subplot(2,1,1);
plot(transpose(hComp),'Color','k');
xlabel('time (ms)');
ylabel('velocity (deg/s)');
set(gca, 'ylim', [0 10], 'tickdir', 'out');

subplot(2,1,2);
plot(transpose(vComp),'Color','k');
xlabel('time (ms)');
ylabel('velocity (deg/s)');
set(gca,'xlim', [0 200], 'ylim', [0 10], 'tickdir', 'out');

sgtitle('Rotated eye velocity components');
axis square;
