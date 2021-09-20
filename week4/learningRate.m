clear
clc
rng('shuffle');

% the parameters are initialized
BASE_RATE = 1/4;
trial = 0;

% to start the while loop, the learning_rate is initialized as -inf
% in common sense, learning_rate should be above 0 and below 1
% if learning_rate = 0, while loop iterates indefinitely
% therfore the conditions should be as follows
learning_rate = -inf;

while (learning_rate <= 0) || (learning_rate >= 1)
    learning_rate = input("Enter the learning rate you want between 0 and 1: ");
end

% to start the while loop, the criterion is initialized as -inf
% in common sense, criterion must be at least BASE_RATE or above
% since p_correct cannot exceed 1, criterion also cannot exceed 1
% therfore the conditions should be as follows
criterion = -inf;

while (criterion < BASE_RATE) || (criterion > 1)
    criterion = input("Enter the criterion you want between 0.25 and 1: ");
end

% to start the while loop, p_correct is initialized as -inf
% if p_correct reach the criterion, the while loop ends
% each iteration increases the trial by 1
% if p_correct exceed 1, p_correct is corrected to 1
p_correct = -inf;

while (p_correct < criterion)
    trial = trial + 1
    p_correct = BASE_RATE + learning_rate * log(trial)

    if p_correct > 1
        p_correct = 1
    end

end
