function varargout = DataBase(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataBase_OpeningFcn, ...
                   'gui_OutputFcn',  @DataBase_OutputFcn, ...
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

function DataBase_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
global tabledata; 
if ~exist('tabledata') %reopen DataBase after adding new info
    tabledata={}; %Info will remain unless Matlab is closed
end
set(handles.uitable1,'data',tabledata);

function varargout = DataBase_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function button_plot_Callback(hObject, eventdata, handles)
global tabledata;
len=size(tabledata,1);
if len<1
    errordlg('No Data !','Warning');
    return;
end
x=[1:len];
for i=len*2+1:len*3
    y1(i-len*2)=tabledata{i};
    if(tabledata{i}<60)
        errordlg(strcat(tabledata{i-len*2},'''s Chinese faild'),'Warning');
    end
end
for i=len*3+1:len*4
    y2(i-len*3)=tabledata{i};
    if(tabledata{i}<60)
        errordlg(strcat(tabledata{i-len*3},'''s Math faild'),'Warning');
    end
end
for i=len*4+1:len*5
    y3(i-len*4)=tabledata{i};
    if(tabledata{i}<60)
        errordlg(strcat(tabledata{i-len*4},'''s English faild'),'Warning');
    end
end
for i=len*5+1:len*6
    y4(i-len*5)=tabledata{i};
end
figure;
plot(x,y1);
hold on;
plot(x,y2);
plot(x,y3);
plot(x,y4);
legend('Chinese','Math','English','Total');
title('Data Comparison');
grid on;

function button_add_Callback(hObject, eventdata, handles)
AddInfo;

function button_clear_Callback(hObject, eventdata, handles)
global tabledata;
tabledata = {};
set(handles.uitable1,'data',tabledata);

function button_exit_Callback(hObject, eventdata, handles)
close;
