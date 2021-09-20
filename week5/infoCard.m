clear
clc
% 'questions' is a 5x1 string
questions = [
        "What's your name? "
        "How old are you? "
        "Are you male or female? "
        "Where is your home country? "
        "What's your favorite color? "
        ];

% the struct array 'questionnaire' which has 5 questions is initialized
[questionnaire(1:length(questions)).question] = questions{:};

% ask questions using 'input', fill up the questionnaire
% and record the time-lapse in each question using 'tic' and 'toc'
for idx = 1:length(questionnaire)
    tic;
    questionnaire(idx).answser = input(questionnaire(idx).question, 's');
    questionnaire(idx).time = toc;
end

% organize participant data from answers into struct array
participant.name = questionnaire(1).answser;
participant.age = questionnaire(2).answser;
participant.sex = questionnaire(3).answser;
participant.nationality = questionnaire(4).answser;
participant.favcolor = questionnaire(5).answser;

% create a text file and write the data
% print questions and answers alternately + Time
filename = 'data.txt';
fid = fopen(filename, 'wt');

for idx = 1:length(questionnaire)
    fprintf(fid, "Q.%d : %s\n", idx, questionnaire(idx).question);
    fprintf(fid, "A.%d : %s\n", idx, questionnaire(idx).answser);
    fprintf(fid, "Time: %.2fs\n\n", questionnaire(idx).time);
    % to the second digit below the decimal point
end

% participant information cards is made from data in the participant structure array
fprintf(fid, "==Participant Info. Card==\n");
fprintf(fid, " - Name : %s\n", participant.name);
fprintf(fid, " - Age : %s\n", participant.age);
fprintf(fid, " - Sex : %s\n", participant.sex);
fprintf(fid, " - Nationality : %s\n", participant.nationality);
fprintf(fid, " - Favorite color : %s\n", participant.favcolor);
fclose(fid);
type(filename);
