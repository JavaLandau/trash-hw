function varargout = Sketch(varargin)
% SKETCH MATLAB code for Sketch.fig
%      SKETCH, by itself, creates a new SKETCH or raises the existing
%      singleton*.
%
%      H = SKETCH returns the handle to a new SKETCH or the handle to
%      the existing singleton*.
%
%      SKETCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SKETCH.M with the given input arguments.
%
%      SKETCH('Property','Value',...) creates a new SKETCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sketch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sketch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sketch

% Last Modified by GUIDE v2.5 21-Sep-2017 22:09:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sketch_OpeningFcn, ...
                   'gui_OutputFcn',  @Sketch_OutputFcn, ...
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

function binaryClockEvaluation(arrayTime)
global arrayPointsClock;

for i = 1:6
    binaryPres = dec2bin(arrayTime(i));        

    binPos = 0;
    for j = length(binaryPres):-1:1
        binPos = binPos + 1;
        if (strcmp(binaryPres(j),'0'))
            set(arrayPointsClock(binPos,i), 'Visible', 'off');
            set(arrayPointsClock(binPos,i), 'UserData', 0);
        else
            set(arrayPointsClock(binPos,i), 'Visible', 'on');
            set(arrayPointsClock(binPos,i), 'UserData', 1);
        end
    end

    for j = length(binaryPres)+1:4
        set(arrayPointsClock(j,i), 'Visible', 'off');
        set(arrayPointsClock(j,i), 'UserData', 0);
    end
end

% --- Executes just before Sketch is made visible.
function Sketch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sketch (see VARARGIN)
global arrayPointsClock;
global newValueClock;
global curIndexClock;
global statusClock;
global statusRedraw;

% Choose default command line output for Sketch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

statusClock = 1;
statusRedraw = 0;
radius = 2;
angle = 0:0.01:2*pi;
arrayPointsClock = zeros(4, 6);
newValueClock = ones(1, 6);
curIndexClock = 1;
X = radius*cos(angle);
Y = radius*sin(angle);
tempBuffHanldleAxes = [handles.axes24 handles.axes23 handles.axes22 handles.axes21;
                       handles.axes20 handles.axes19 handles.axes18 handles.axes17;
                       handles.axes16 handles.axes15 handles.axes14 handles.axes13;
                       handles.axes12 handles.axes11 handles.axes10 handles.axes9;
                       handles.axes8 handles.axes7 handles.axes6 handles.axes5;
                       handles.axes4 handles.axes3 handles.axes2 handles.axes1];
tempBuffHanldleAxes = tempBuffHanldleAxes';


for i = 1:4
    for j = 1:2
        axes(tempBuffHanldleAxes(i,j));  %#ok<LAXES>
        hold('on');
        arrayPointsClock(i,j) = fill(X, Y, [0 1 0], 'Parent', tempBuffHanldleAxes(i,j));
    end
    
    for j = 3:4
        axes(tempBuffHanldleAxes(i,j));  %#ok<LAXES>
        hold('on');
        arrayPointsClock(i,j) = fill(X, Y, [1 1 0], 'Parent', tempBuffHanldleAxes(i,j));
    end    
    
    for j = 5:6
        axes(tempBuffHanldleAxes(i,j));  %#ok<LAXES>
        hold('on');
        arrayPointsClock(i,j) = fill(X, Y, [1 0 0], 'Parent', tempBuffHanldleAxes(i,j));
    end    
end

countPostRedraw = 0;
seconds = 21;
minutes = 21;
hours = 21;
while (statusClock ~= 0)
    %{
    curTime = rem(now(), 1);        
    hours = floor(curTime*24);
    curTime = rem(curTime*24, 1);
    minutes = floor(curTime*60);
    curTime = rem(curTime*60, 1);
    seconds = floor(curTime*60);
     %}
    
    seconds = seconds + 1;
    
    if (seconds == 60)
        seconds = 0;
        minutes = minutes + 1;
    end
    
    if (minutes == 60)
        minutes = 0;
        hours = hours + 1;
    end
    
    if (hours == 24)
        hours = 0;
    end
    
    arrayTime = [seconds - 10*floor(seconds / 10) floor(seconds / 10),...
                 minutes - 10*floor(minutes / 10) floor(minutes / 10),...
                 hours - 10*floor(hours / 10) floor(hours / 10)];          
    binaryClockEvaluation(arrayTime);
    
    pause(1);            
    if (statusClock == 2)
        blinkStatus = 0;
        binaryClockEvaluation(newValueClock);
        while (statusClock == 2)             
            blinkStatus = 1 - blinkStatus;
            if (blinkStatus)
                for j = 1:4  
                    if (get(arrayPointsClock(j,curIndexClock), 'UserData') == 1)
                        set(arrayPointsClock(j,curIndexClock), 'Visible', 'on');
                    end
                end
            else
                for j = 1:4
                    set(arrayPointsClock(j,curIndexClock), 'Visible', 'off');
                end
            end
            pause(0.2);
            
            if (statusRedraw == 1 && countPostRedraw == 0)
                binaryClockEvaluation(newValueClock);                
            end
            
            if (statusRedraw == 1)
               countPostRedraw = countPostRedraw + 1;
            end
            
            if (countPostRedraw == 2)
                statusRedraw = 0;
                countPostRedraw = 0;
            end
        end
        
        seconds = newValueClock(1) + 10*newValueClock(2);
        minutes = newValueClock(3) + 10*newValueClock(4);
        hours = newValueClock(5) + 10*newValueClock(6);
        newValueClock = ones(1,6);
    end
end

% UIWAIT makes Sketch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sketch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close;

function axes1_CreateFcn(hObject, eventdata, handles)


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
global newValueClock;
global curIndexClock;
global statusClock;
global statusRedraw;

switch eventdata.Key
    case 'f1'
        statusClock = 3 - statusClock;
    case 'leftarrow'
        if (statusClock == 2 && statusRedraw == 0)
            curIndexClock = curIndexClock + 1;
            if (curIndexClock == 7)
                curIndexClock = 1;
            end
            statusRedraw = 1;
        end
    case 'uparrow'
        if (statusClock == 2 && statusRedraw == 0)
            newValueClock(curIndexClock) = newValueClock(curIndexClock) + 1;
            switch curIndexClock
                case {1, 3}
                    if (newValueClock(curIndexClock) > 9)
                        newValueClock(curIndexClock) = 0;
                    end
                case {2, 4}
                    if (newValueClock(curIndexClock) > 5)
                        newValueClock(curIndexClock) = 0;
                    end
                case 5
                    if (newValueClock(curIndexClock) > 9)
                        newValueClock(curIndexClock) = 0;
                    elseif (newValueClock(curIndexClock) > 3 && newValueClock(6) == 2)
                        newValueClock(curIndexClock) = 0;
                    end
                case 6
                    if (newValueClock(curIndexClock) > 2)
                        newValueClock(curIndexClock) = 0;
                    elseif (newValueClock(curIndexClock) > 1 && newValueClock(5) > 3)
                        newValueClock(curIndexClock) = 0;
                    end                
            end
            statusRedraw = 1;
        end
    case 'escape'
        statusClock = 0;
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
