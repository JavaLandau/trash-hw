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

% Last Modified by GUIDE v2.5 27-Dec-2017 11:02:09

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


% --- Executes just before Sketch is made visible.
function Sketch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sketch (see VARARGIN)

% Choose default command line output for Sketch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sketch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sketch_OutputFcn(hObject, eventdata, handles) 
global FlagExit

FlagExit = false;

varargout{1} = handles.output;

FaceColor = [0.94 0.94 0.94];
RedColor = [1 0 0];
GreenColor = [0 1 0];
OrangeColor = [1 0.5 0];
MagentaColor = [1 0 1];
BlueColor = [0 0 1];
CyanColor = [0 1 1];
WhiteColor = [1 1 1];

NUM_AXES_FOR_CLOCKS = 60;
NUM_TEXT_FOR_CLOCKS = 12;
AxesForClock = zeros(NUM_AXES_FOR_CLOCKS,1);
FillsForClock = zeros(NUM_AXES_FOR_CLOCKS,1);
TextForClock = zeros(NUM_TEXT_FOR_CLOCKS,1);

R = 8;
r = 1;
SizeClocks = 0.6;
SizeCenter = 1;

angle = 0:0.01:2*pi;
Xfill = cos(angle);
Yfill = sin(angle);

scrnsize = get(0, 'ScreenSize'); 
Pos = zeros(1,4);

Pos(3) = 2*R + 2;
Pos(4) = 2*R + 2;
set(hObject,'Position',Pos);
set(hObject,'Units','pixels','Name','Светодиодные часы');
PosBuff = get(hObject,'Position');

PosBuff(1) = (scrnsize(3) - PosBuff(3))/2;
PosBuff(2) = (scrnsize(4) - PosBuff(4))/2;
set(hObject,'Position',PosBuff);
set(hObject,'Units','centimeters');

Xo = Pos(3)/2;
Yo = Pos(4)/2;

for i = 1:NUM_AXES_FOR_CLOCKS
    fi = 2*pi*(i - 1)/NUM_AXES_FOR_CLOCKS;
    X = R*sin(fi) + Xo - SizeClocks/2;
    Y = R*cos(fi) + Yo - SizeClocks/2;
        
    AxesForClock(i) = axes('Units','centimeters','Position',[X Y SizeClocks SizeClocks],'Parent',hObject);
    FillsForClock(i) = fill(Xfill, Yfill, WhiteColor,'EdgeColor','none','Parent', AxesForClock(i));
    set(AxesForClock(i),'XTick',[],'YTick',[],'ZTick',[],'Box','off','XColor',FaceColor,'YColor',FaceColor,...
        'Color',FaceColor);

    if(rem(i - 1,5) == 0)
        SizeText = 0.95;
        
        num = (i - 1)/5;
        X = (R - r)*sin(fi) + Xo - SizeText/2;
        Y = (R - r)*cos(fi) + Yo - SizeText/2;
        
        if(num == 0)
            num = 12;
        end
        
        TextForClock(num) = uicontrol('Style','text','Units','centimeters','FontSize',20,...
                                      'HorizontalAlignment','center','String',num2str(num),'Parent',hObject);
        set(TextForClock(num),'Position',[X Y SizeText SizeText]);
    end
end

AxesForCenter   = axes('Units','centimeters','XColor',FaceColor,...
                       'YColor',FaceColor,'ZColor',FaceColor,...
                       'Color',FaceColor,'Position',[Xo - SizeCenter/2 Yo - SizeCenter/2 SizeCenter SizeCenter],...
                       'Parent',hObject);
FillsForCenter = fill(Xfill, Yfill, OrangeColor,'EdgeColor','none','Parent', AxesForCenter);  
set(AxesForCenter,'XTick',[],'YTick',[],'ZTick',[],'Box','off','XColor',FaceColor,'YColor',FaceColor,...
    'Color',FaceColor);

while(~FlagExit)    
    for i = 1:NUM_AXES_FOR_CLOCKS
        set(FillsForClock(i),'FaceColor',WhiteColor);
    end
    
    time = fix(clock);
    [hours,minutes,seconds] = deal(time(4),time(5) + 1,time(6) + 1);
    
    if(hours >= 12)
        hours = rem(hours,12);
    end
    
    numHours = hours*5 + 1;
    
    set(FillsForClock(numHours),'FaceColor',RedColor);
    
    if(minutes == numHours)
        set(FillsForClock(numHours),'FaceColor',OrangeColor);
    else
        set(FillsForClock(minutes),'FaceColor',GreenColor);
    end
    
    if(seconds == minutes && seconds == numHours)
        set(FillsForClock(numHours),'FaceColor',WhiteColor);
    elseif(seconds == numHours)
        set(FillsForClock(numHours),'FaceColor',MagentaColor);
    elseif(seconds == minutes)
        set(FillsForClock(minutes),'FaceColor',CyanColor);
    else
        set(FillsForClock(seconds),'FaceColor',BlueColor);
    end
        
    pause(1);
end

close;



% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
global FlagExit

if(strcmp(eventdata.Key,'escape'))
    FlagExit = true;
end
    
