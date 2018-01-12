function varargout = Algorithm(varargin)
% ALGORITHM MATLAB code for Algorithm.fig
%      ALGORITHM, by itself, creates a new ALGORITHM or raises the existing
%      singleton*.
%
%      H = ALGORITHM returns the handle to a new ALGORITHM or the handle to
%      the existing singleton*.
%
%      ALGORITHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALGORITHM.M with the given input arguments.
%
%      ALGORITHM('Property','Value',...) creates a new ALGORITHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Algorithm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Algorithm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Algorithm

% Last Modified by GUIDE v2.5 12-Oct-2017 11:32:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Algorithm_OpeningFcn, ...
                   'gui_OutputFcn',  @Algorithm_OutputFcn, ...
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


% --- Executes just before Algorithm is made visible.
function Algorithm_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for Algorithm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = Algorithm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
global UARTParams
global Fmax
global UARTBaudrate

Fmax = 600000;
UARTBaudrate = 115200;
baudrate = round(Fmax / UARTBaudrate);
UARTParams = struct('baudrate',baudrate,'bits_count',8,'parity','none','stop_bits','stopbit_1');
