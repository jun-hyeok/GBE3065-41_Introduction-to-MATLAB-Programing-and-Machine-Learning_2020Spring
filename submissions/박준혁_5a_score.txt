clear
clc
% G is a 5x3 cell array
G = {
    'Adam' 'Brad' 'Charley' 'David' 'Emily'
    90 92 96 95 88
    'A-' 'A-' 'A' 'A' 'B'
    }';

% studentStruct is struct array with two fields, name amd average
[studentStruct(1:5).name] = G{:,1};
[studentStruct.average] = G{:,2};

% the new field, letter is added
% criterion scores :
% 95 or higher ('A'), 
% 90 to 95 ('A-')
% 85 to 90 ('B+')
% otherwise ('B')
for idx = 1:length(studentStruct) 
    if studentStruct(idx).average >= 95
        studentStruct(idx).letter = 'A';
    elseif studentStruct(idx).average >= 90
        studentStruct(idx).letter = 'A-';
    elseif studentStruct(idx).average >= 85
        studentStruct(idx).letter = 'B+';
    else
        studentStruct(idx).letter = 'B';
    end
end

% create a text file and write the data
filename = 'score.txt';
fid = fopen(filename, 'wt');
for idx = 1:length(studentStruct)
    fprintf(fid, "%s's average is %d, %s got %s\n", ...
        studentStruct(idx).name, studentStruct(idx).average, ...
        studentStruct(idx).name, studentStruct(idx).letter);
end
fclose(fid);
type(filename);