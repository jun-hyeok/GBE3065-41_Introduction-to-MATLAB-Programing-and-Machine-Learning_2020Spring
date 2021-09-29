%% exercise 1
clear
rng('default')
data(:,1) = randperm(300); % student numbers (1 to 300)
data(:,2) = randi(4,300,1) + 14; % class year (15 to 18)
data(:,3) = randi(20,300,1)/10 + 2; % GPA (2.0 to 4.0)
format short
checkvalues = mean(data)

honorStudent = [];
honorGrad = [];
undergrad1Year = [];
undergrad2Year = [];
for iData = 1:size(data, 1)
    
    % 1. students with GPA 4.0
    if data(iData, 3) == 4
        honorStudent = [honorStudent ; data(iData, :)];
    end
    
    % 2. the seniors who will graduate with honors (GPA >= 3.5)
    if (data(iData, 2) == 15) && (data(iData, 3) >= 3.5)
        honorGrad = [honorGrad ; data(iData, :)];
    end
    
    % GPA of student #1
    if data(iData, 1) == 1
        studentNo1_GPA = data(iData, 3)
    end
    
    % first-year students
    if data(iData, 2) == 18
        undergrad1Year = [undergrad1Year ; data(iData, :)];
    end
    
    % second-year students
    if data(iData, 2) == 17
       undergrad2Year = [undergrad2Year ; data(iData, :)];
    end
    
end

% 3. the number of GPA 3.0 or higher in first-year students
majorPsychology = sum(undergrad1Year(:, 3) >= 3)

% 4. standard deviation of the GPAs of second-year students
std_undergrad2Year = std(undergrad2Year(:,3))
%% exercise 2
% write and save data in text file
fid = fopen('studentGPA.txt', 'wt');

% from exercise 1, students with GPA 4.0
fprintf(fid, "Students with GPA 4.0\n\n");
fprintf(fid, "%-4s%-4s%-4s\n\n","ID", "Yr", "GPA");
for i = 1:size(honorStudent, 1)
    fprintf(fid, "%-4d%-4d%-4.1f\n", honorStudent(i,:));
end

% from exercise 1, the seniors who will graduate with honors
fprintf(fid, "\nThe seniors who will graduate with honors\n\n");
fprintf(fid, "%-4s%-4s%-4s\n\n","ID", "Yr", "GPA");
for i = 1:size(honorGrad, 1)
    fprintf(fid, "%-4d%-4d%-4.1f\n", honorGrad(i,:));
end

% from exercise 1, first-year students who are likely to elect to be Psychology majors
fprintf(fid, "\nFirst-year students who are likely to elect to be Psychology majors\n");
fprintf(fid, "Total : %d students\n\n",majorPsychology);
fprintf(fid, "%-4s%-4s%-4s\n\n","ID", "Yr", "GPA");
for i = 1:size(undergrad1Year, 1)
    if undergrad1Year(i, 3) >= 3
        fprintf(fid, "%-4d%-4d%-4.1f\n", undergrad1Year(i,:));
    end
end

fclose(fid);
type('studentGPA.txt');