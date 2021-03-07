function main;
% Initialize variables common to main and nested subfunctions
month = 'January';
year = 2001;

% Open the figure for the interface
handletothefigure = figure;

% Install a popup menu for the months
monthstrings = {
    'Month'
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'};
hmonth = uicontrol(...
    'Style', 'popupmenu', ...
    'String', monthstrings, ...
    'Position', [120 320 100 20], ...
    'Callback', @monthcallback);

% Install a popup menu for the years
hyear = uicontrol(...
    'Style', 'popupmenu', ...
    'String', 'Year|2008|2009|2010|2011|2012|2013|2014|2015|2016|2017|2018', ...
    'Position', [220 320 100 20], ...
    'Callback', @yearcallback);

% Install an informative text field for the popup controls
uicontrol(...
    'Style', 'text', ...
    'String', 'Pick a month and a year: ', ...
    'Position', [120, 360, 200, 15]);

% Install a GO button
hgobutton = uicontrol(...
    'Style', 'pushbutton', ...
    'String', 'Look up days in the month', ...
    'Position', [120 120 200 40], ...
    'Callback', @gobuttoncallback);

% Now just wait for the user to finish (when the window closes)
uiwait(handletothefigure)
return % from main

% Callback routines in nested functions:
    function monthcallback(source, eventdata)
        mylist = (get(source,'String'));
        myitem = (get(source,'Value'));
        month = char(mylist(myitem));
    end

    function yearcallback(source, eventdata)
        mylist = (get(source,'String'));
        myitem = (get(source,'Value'));
        year = str2num(mylist(myitem, :));
    end

    function gobuttoncallback(source, eventdata)     
        % Days_In_A_Month
        switch month
            case {'September' 'April' 'June' 'November'}
                no_of_days = 30; % 4월, 6월, 9월, 11월
            case 'February' % 2월
                if rem(year, 4) == 0 & (rem(year,100) ~= 0 | rem(year, 400) == 0) 
                    no_of_days = 29; % year가 100의 배수는 아니고 400의 배수는 포함하는 4의 배수일 때
                else
                    no_of_days = 28;
                end
            otherwise
                no_of_days = 31; % 1월, 3월, 5월, 7월, 8월, 10월, 12월
        end
        hmsg = msgbox(sprintf('%s %d has %d days.\n', month, year, no_of_days));
        uiwait(hmsg)
        close(handletothefigure)
    end
end % function main
