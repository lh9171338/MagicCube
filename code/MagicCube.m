function varargout = MagicCube(varargin)
% MAGICCUBE MATLAB code for MagicCube.fig
%      MAGICCUBE, by itself, creates a new MAGICCUBE or raises the existing
%      singleton*.
%
%      H = MAGICCUBE returns the handle to a new MAGICCUBE or the handle to
%      the existing singleton*.
%
%      MAGICCUBE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAGICCUBE.M with the given input arguments.
%
%      MAGICCUBE('Property','Value',...) creates a new MAGICCUBE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MagicCube_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MagicCube_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MagicCube

% Last Modified by GUIDE v2.5 06-Aug-2019 20:15:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MagicCube_OpeningFcn, ...
                   'gui_OutputFcn',  @MagicCube_OutputFcn, ...
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


% --- Executes just before MagicCube is made visible.
function MagicCube_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MagicCube (see VARARGIN)

% Choose default command line output for MagicCube
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MagicCube wait for user response (see UIRESUME)
% uiwait(handles.figure);
clc;
%% Define global variables
global option;
global Rotate;
Rotate.Index = 0;
option = struct('Order', 3, 'Size', 10, 'Draw3d', true, 'Iter', 20);

% --- Outputs from this function are returned to the command line.
function varargout = MagicCube_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%% Initial the magic cube
global MagicCube;
global option;
MagicCube = InitMagicCube(option);
DrawMagicCube(MagicCube);

% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = dialog('Position', [500 500 400 400], 'Name', 'Help Dialog');
uicontrol('Parent', d, ...
           'Style', 'text', ...
           'Position', [40 80 320 300], ...
           'fontsize',12, ...
           'HorizontalAlignment', 'left', ...
           'String', {'Usage:', ...
           '', ...
           '''W''/''w'': Rotate front -> top -> back -> bottom', ...
           '''S''/''s'': Rotate front -> bottom -> back -> up', ...
           '''A''/''a'': Rotate front -> left -> back -> right', ...
           '''D''/''d'': Rotate front -> right -> back -> left', ...
           '''Q''/''q'': Rotate top -> left -> bottom -> right', ...
           '''E''/''e'': Rotate top -> right -> bottom -> left', ...
           '', ...
           '''0'': Rotate all rows or columns', ...
           '''1'': Rotate 1th row or column', ...
           '...', ...
           '''N''(N = order): Rotate Nth row or column'});
uicontrol('Parent', d,...
           'Position', [160 20 80 40],...
           'String', 'Close',...
           'Callback', 'delete(gcf)');

% --- Executes on key press with focus on figure or any of its controls.
function figure_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global MagicCube;
global Rotate;
order = MagicCube.Param.Order;
if MagicCube.Block.Finish
    d = dialog('Position', [500 500 200 120], 'Name', 'Message');
    uicontrol('Parent', d, ...
               'Style', 'text', ...
               'Position', [20 80 160 20], ...
               'fontsize',12, ...
               'HorizontalAlignment', 'center', ...
               'String', 'Congratulation!!!');
    uicontrol('Parent', d,...
               'Position', [60 20 80 40],...
               'String', 'Close',...
               'Callback', 'close all');
    return;
end
keyvalue = eventdata.Character;
switch keyvalue
    case {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
        if order >= str2double(keyvalue)
            Rotate.Index = str2double(keyvalue);
        end
    case {'W', 'w'}
        Rotate.Direction = 'U';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
    case {'S', 's'}
        Rotate.Direction = 'D';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
    case {'A', 'a'}
        Rotate.Direction = 'L';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
    case {'D', 'd'}
        Rotate.Direction = 'R';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
    case {'Q', 'q'}
        Rotate.Direction = 'A';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
    case {'E', 'e'}
        Rotate.Direction = 'C';
        MagicCube = RotateMagicCube(MagicCube, Rotate);
        DrawMagicCube(MagicCube);
end


% --- Executes on key release with focus on figure or any of its controls.
function figure_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
global MagicCube;
global Rotate;
order = MagicCube.Param.Order;
keyvalue = eventdata.Character;
switch keyvalue
    case {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
        if order >= str2double(keyvalue)
            Rotate.Index = 0;
        end
end
