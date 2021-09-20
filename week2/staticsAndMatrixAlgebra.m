rng('shuffle')
% MEAN and SD are constant in exercise 1 and 3
MEAN = 500;
SD = 100;

%% exercise 1
% satscores is (100 x 10) matrix of scores that normally distributed and its mean = 500, sd = 100
satscores = randn(100, 10) * SD + MEAN;
mean_satscores = mean(satscores(:))
std_satscores = std(satscores(:))
histogram(satscores(:));

%% exercise 2
% M is a random integer vector that has 100 elements
M = randi(100, 1, 100);
mean_M = mean(M(:))
std_M = std(M(:))

idx = randi(100, 1, 20); % randomly draw idxArray
drawedValues = M(idx(:)); % randomly draw 20 elements from M
mean_drawedValues = mean(drawedValues(:))
std_drawedValues = std(drawedValues(:))

%% excercise 3
% SATs is (1400 x 2) matrix of multiples of 10 that normally distributed and its mean = 500, sd = 100
SATs = round(randn(1400, 2) * SD + MEAN, -1);
colmean_SATs = mean(SATs)
colstd_SATs = std(SATs)

%% exercise 4 to 7
% mathScores is (100 x 3) matrix that contains NaNs
load('mathScores.mat');

% exercise 4
classmean_mathScores = nanmean(mathScores)
classstd_mathScores = nanstd(mathScores)
mean_mathScores = nanmean(mathScores(:))
std_mathScores = nanstd(mathScores(:))

% exercise 5
vacancy = numel(mathScores(isnan(mathScores)))

% exercise 6
newScores = mathScores; % copy
newScores(isnan(newScores)) = -10; % replace NaN with -10
mean_newScores = mean(newScores(:))
std_newScores = std(newScores(:))

% exercise 7
% old scores histograms
histogram(mathScores(:, 1), 'FaceColor', 'r');
histogram(mathScores(:, 2), 'FaceColor', 'g');
histogram(mathScores(:, 3), 'FaceColor', 'b');
% new scores histograms
histogram(newScores(:, 1), 'FaceColor', 'r');
histogram(newScores(:, 2), 'FaceColor', 'g');
histogram(newScores(:, 3), 'FaceColor', 'b');

%% exercise 8
% floor(x) returns the greatest integer less than or equal to x
% ceil(x) returns the least integer greater than or equal to x

floor_pos = floor(pi);
ceil_pos = ceil(pi);
fix_pos = fix(pi);
table(floor_pos, ceil_pos, fix_pos)
floor_neg = floor(-pi);
ceil_neg = ceil(-pi);
fix_neg = fix(-pi);
table(floor_neg, ceil_neg, fix_neg)

% if x is positive, fix(x)==floor(x) as shown in the first table
% if x is negative, fix(x)==ceil(x) as shown in the second table
% Generaly, fix(x)==round(x, 0)
