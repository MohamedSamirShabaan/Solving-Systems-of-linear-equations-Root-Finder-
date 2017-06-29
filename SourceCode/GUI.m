function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%**************************************************************************
%GUI Done.

function str = openFile()
     str =  textread(uigetfile('*.txt','choose a file'),'%s');

function readFile_Callback(hObject, eventdata, handles)
str = openFile();
set(handles.funEdit,'string',str);


% --- Executes on button press in solve.
function solve_Callback(~ , ~ , handles)
global tim;
%definition each output edit
root = handles.rootEdit;
timeTaken = handles.timeEdit;
numberOfIteration = handles.ItrEdit;
precisionOut = handles.PercisionResultEdit;
answer = handles.table;

syms x;
symbol(x) = sym(get(handles.funEdit,'string'));
methodChoise = get(handles.menu,'Value');
precisionIn = str2double(get(handles.PercisionEdit,'string'));
maxIterations = str2num(get(handles.MaxItrEdit,'string'));
lowerOrGuess = str2double(get(handles.lower,'string'));
upper = str2double(get(handles.upper,'string'));


try
switch methodChoise
        case 1
            t = cputime; % get time taken
            [~ , rootVect ,errorVect] = bisection(symbol , lowerOrGuess , upper , precisionIn, maxIterations);
            t = cputime-t;
            cla;
            axis([-10 10 -10 10]);
            str = get(handles.funEdit,'string');
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on;          
        case 2
            t = cputime;
            [~ , rootVect , errorVect] = Falseposition(symbol, lowerOrGuess , upper , precisionIn, maxIterations);            
            t = cputime-t;
            cla;
            axis([-10 10 -10 10]);
            str = get(handles.funEdit,'string');
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on; 
        case 3
            t = cputime;
            symbol = symbol + x;
            [~ , rootVect ,errorVect] = fixedPoint(symbol , lowerOrGuess , precisionIn, maxIterations);
            t = cputime-t;
            cla;
            axis([-10 10 -10 10]);
            str = char(symbol);
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on; 
        case 4
            t = cputime;
            [~ , rootVect ,errorVect] = newtonRaph(symbol , lowerOrGuess, precisionIn, maxIterations);
            t = cputime-t;
            symbol = diff(symbol);
            cla;
            axis([-10 10 -10 10]);
            str = char(symbol);
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on; 
        case 5
             t = cputime;
             [~ , rootVect ,errorVect] = secant(symbol , lowerOrGuess , upper, precisionIn, maxIterations);
             t = cputime-t;
             symbol = diff(symbol);
            cla;
            axis([-10 10 -10 10]);
            str = char(symbol);
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on;
       case 6
            %vita
             t = cputime;
             [~ , rootVect ,errorVect] = vieta(symbol , lowerOrGuess, precisionIn, maxIterations);
             t = cputime-t;
            symbol = diff(symbol);
            cla;
            axis([-10 10 -10 10]);
            str = char(symbol);
            Plan = handles.Plan;
            axis(Plan);
            ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on;
        case 7
            tim = .55;
            [~,rootVect,errorVect] = bisectionSim(answer, handles.Plan , symbol , lowerOrGuess , upper, precisionIn, maxIterations);
t = 0;
end
catch e
    errordlg(e.message,'Error')
    return;
end
[~ , si] = size(rootVect);
result = zeros(si , 4);
for counter=1:si
    result(counter,1) = counter;
    result(counter,2) = rootVect(counter);
    result(counter,3) = errorVect(counter);
    result(counter,4) = errorVect(counter)*100;
end
result(1,3) = 0;
result(1,4) = 0;
set(answer,'data',result);
set(numberOfIteration,'String', result(end,1));
set(root, 'String', result(end,2));
set(precisionOut, 'String', result(end,3));
set(timeTaken , 'String', t);
set(answer,'data',result);

% --- Executes on button press in plot.
function plot_Callback(~ , ~ , handles)
axis([-10 10 -10 10]);
str = get(handles.funEdit,'string');
Plan = handles.Plan;
axis(Plan);
ezplot(str , [-10 , 10 , -10 , 10]),grid on , zoom on;

% --- Executes on button press in clearResult.
function clearResult_Callback(hObject, eventdata, handles)
answer = handles.table;
result = cell(size(get(answer,'data')));
set(answer,'data',result);

% --- Executes on button press in clearPlot.
function clearPlot_Callback(hObject, eventdata, handles)
cla;

function frame_CloseRequestFcn(hObject, ~, ~)
delete(hObject);

%***************************************************** 
%edit don't implement

function lower_Callback(hObject, eventdata, handles)

function lower_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upper_Callback(hObject, eventdata, handles)

function upper_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function funEdit_Callback(hObject, eventdata, handles)

function funEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function menu_Callback(hObject, eventdata, handles)

function menu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MaxItrEdit_Callback(hObject, eventdata, handles)

function MaxItrEdit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PercisionEdit_Callback(hObject, eventdata, handles)

function PercisionEdit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
