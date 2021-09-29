function SimonDemo;
    clc
    clear
    close all;
    sinit = input('Subject''s initials: ', 's');
    outfilename = ['SimonData_' sinit];
    rawdataoutfilename = strrep(outfilename, '_', '_Rawdata_');
    rawdataoutfilename = strcat(rawdataoutfilename, '.txt');
    rawdatafile = fopen(rawdataoutfilename, 'w');
    fprintf(rawdatafile, 'Trial\tside\tstim\tcomp\tKey\tResp.\tRT\n');
    screensize = get(0, 'screensize');
    % SetScreen
    %hfig = figure('position',[0 0 screensize(3) 200],'color', [1 1 1]);
    hfig = figure('position', [0 screensize(4) / 2 - 200 screensize(3) 400], 'color', [1 1 1]);

    % DefineTrialTypes
    [ttype(1:4).side] = deal('L', 'R', 'L', 'R');
    [ttype(1:4).stim] = deal('L', 'L', 'R', 'R');
    [ttype(1:4).comp] = deal('C', 'I', 'I', 'C');

    % InitializeData.
    [ttype(1:4).RT] = deal([]);
    [ttype(1:4).error] = deal(0);
    %Run 8 blocks of the four types in random order (32 in all);
    trialnumber = 0;

    for blocknumber = 1:8

        for typenum = randperm(4);
            trialnumber = trialnumber + 1;
            pause(2)
            hfix = text(.5, .5, '+', 'fontsize', 36);
            axis off
            set(gca, 'position', [0 0 1 1])
            pause(1)
            % Run the trial
            if ttype(typenum).side == 'L'
                stimposition = .1;
            else
                stimposition = .9;
            end

            hstim = text(stimposition, .5, ttype(typenum).stim, 'fontsize', ...
                72, 'fontweight', 'bold');
            tic
            waitforbuttonpress
            % Record the response
            thisRT = toc;
            thechar = get(gcf, 'CurrentCharacter');
            delete([hfix hstim]);

            switch thechar
                case 'a'
                    thisResp = 'L';
                case ';'
                    thisResp = 'R';
                otherwise
                    thisResp = 'X'; % illegal key
            end

            if ttype(typenum).stim == thisResp
                ttype(typenum).RT = [ttype(typenum).RT thisRT];
                fprintf(rawdatafile, '%2d\t%s\t%s\t%s\t%s\tcorrect\t%5.2f\n', ...
                    trialnumber, ...
                    ttype(typenum).side, ...
                    ttype(typenum).stim, ...
                    ttype(typenum).comp, thisResp, thisRT);
            else
                ttype(typenum).error = ttype(typenum).error + 1;
                beep
                fprintf(rawdatafile, '%2d\t%s\t%s\t%s\t%s\terror\t%5.2f\n', ...
                    trialnumber, ...
                    ttype(typenum).side, ...
                    ttype(typenum).stim, ...
                    ttype(typenum).comp, thisResp, thisRT);
            end

        end

    end

    save(outfilename, 'ttype');
    fclose(rawdatafile);
