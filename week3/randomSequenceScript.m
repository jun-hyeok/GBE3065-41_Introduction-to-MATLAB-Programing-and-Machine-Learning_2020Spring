rng('shuffle')
clc
% initialize the sequence consisting of six 1s and six 2s in a row
sequenceOf1sAnd2s = [ones(1, 6) ones(1, 6) * 2];
done = false;
cycles = 0;

while not(done)
    % count how many cycles have been taken to get the desired results
    cycles = cycles + 1;
    done = true;
    % shuffle the sequenceOf1sAnd2s randomly by permutating the indices
    sequenceOf1sAnd2s = sequenceOf1sAnd2s(randperm(12));

    for i = 4:12
        % Detect any runs of 1's or 2's
        if sequenceOf1sAnd2s(i) == sequenceOf1sAnd2s(i - 1) ...
                & sequenceOf1sAnd2s(i) == sequenceOf1sAnd2s(i - 2) ...
                & sequenceOf1sAnd2s(i) == sequenceOf1sAnd2s(i - 3)
            % if there is any 4 or more runs of 1's or 2's, shuffle again
            done = false;
        end

    end

end

sequenceOf1sAnd2s
cycles
