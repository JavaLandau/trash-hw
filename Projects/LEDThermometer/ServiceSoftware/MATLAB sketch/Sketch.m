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

% Last Modified by GUIDE v2.5 06-Oct-2017 13:52:30

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
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
global AxArray

AxArray = CreateAxes(0.5, [0.19 0.39], [2.08 0.4], hObject);
SetAxes(AxArray, 20);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
