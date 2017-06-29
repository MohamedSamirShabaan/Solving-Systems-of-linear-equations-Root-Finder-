function varargout = MyGui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyGui_OpeningFcn, ...
                   'gui_OutputFcn',  @MyGui_OutputFcn, ...
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

% --- Executes just before MyGui is made visible.
function MyGui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = MyGui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function ValueX_Callback(hObject, eventdata, handles)

function ValueX_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function order_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function order_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in choose.
function choose_Callback(hObject, eventdata, handles)

function choose_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)

global tim;
data = get(handles.table, 'data');
x = data(:,1);
y = data(:,2);
point = get(handles.ValueX, 'String');
order = get(handles.order, 'String');
xi=str2num(point);
n=str2num(order);
choice = get(handles.choose, 'Value');
t = cputime; % get time taken
switch choice
    case 1
        [result, fun, error] = Newton(x,y,xi,n);
    case 2
        [result, fun, error] = lagrange(x,y,xi,n);
    otherwise
end
t = cputime-t;
set(handles.resultText, 'String', result);
set(handles.errors, 'String', error);
set(handles.funcText, 'String', fun);
set(handles.timeText, 'String', t);
axes(handles.axes1);
ezplot(fun , [min(x)-5 , max(x)+5 , min(y)-5 , max(y)+5 ]),grid on , zoom on;
hold on;
scatter(x,y);
scatter(xi,result);
hold off;

function timeText_Callback(hObject, eventdata, handles)

function timeText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resultText_Callback(hObject, eventdata, handles)

function resultText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function funcText_Callback(hObject, eventdata, handles)

function funcText_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)

data = get(handles.table, 'data');
data(end+1,:) = 0;
set(handles.table, 'data', data);

% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)

data = get(handles.table, 'data');
data(end,:) = [];
set(handles.table, 'data', data);

% --- Executes on button press in loadFile.
function loadFile_Callback(hObject, eventdata, handles)

[fileName, path] =  uigetfile('*.txt','choose a file');
if(fileName ~= 0)
    data = dlmread(fullfile(path, fileName));
    set(handles.table, 'data', data);
end

function errors_Callback(hObject, eventdata, handles)

function errors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
