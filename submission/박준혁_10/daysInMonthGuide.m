function varargout = daysInMonthGuide(varargin)
% DAYSINMONTHGUIDE MATLAB code for daysInMonthGuide.fig
%      DAYSINMONTHGUIDE, by itself, creates a new DAYSINMONTHGUIDE or raises the existing
%      singleton*.
%
%      H = DAYSINMONTHGUIDE returns the handle to a new DAYSINMONTHGUIDE or the handle to
%      the existing singleton*.
%
%      DAYSINMONTHGUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAYSINMONTHGUIDE.M with the given input arguments.
%
%      DAYSINMONTHGUIDE('Property','Value',...) creates a new DAYSINMONTHGUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before daysInMonthGuide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to daysInMonthGuide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help daysInMonthGuide

% Last Modified by GUIDE v2.5 18-May-2020 02:40:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @daysInMonthGuide_OpeningFcn, ...
                   'gui_OutputFcn',  @daysInMonthGuide_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before daysInMonthGuide is made visible.
function daysInMonthGuide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to daysInMonthGuide (see VARARGIN)

% Choose default command line output for daysInMonthGuide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global year;
global month;

% UIWAIT makes daysInMonthGuide wait for user response (see UIRESUME)
uiwait(handles.output);


% --- Outputs from this function are returned to the command line.
function varargout = daysInMonthGuide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;


% --- Executes on selection change in popupMonth.
function popupMonth_Callback(hObject, eventdata, handles)
% hObject    handle to popupMonth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global month;
    mylist = cellstr(get(hObject, 'String'));
    myitem = (get(hObject, 'Value'));
    month = (mylist{myitem});
% Hints: contents = cellstr(get(hObject,'String')) returns popupMonth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupMonth


% --- Executes during object creation, after setting all properties.
function popupMonth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupMonth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuYear.
function popupmenuYear_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global year;
    mylist = cellstr(get(hObject, 'String'));
    myitem = (get(hObject, 'Value'));
    year = (mylist{myitem});
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuYear contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuYear


% --- Executes during object creation, after setting all properties.
function popupmenuYear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbtn.
function pushbtn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Days_In_A_Month
global year;
global month;
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
hmsg = msgbox(sprintf('%s %s has %d days.\n', month, year, no_of_days));
uiwait(hmsg)
close(handles.output)
