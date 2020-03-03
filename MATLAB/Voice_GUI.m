function varargout = Voice_GUI(varargin)
% VOICE_GUI MATLAB code for Voice_GUI.fig
%      VOICE_GUI, by itself, creates a new VOICE_GUI or raises the existing
%      singleton*.
%
%      H = VOICE_GUI returns the handle to a new VOICE_GUI or the handle to
%      the existing singleton*.
%
%      VOICE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICE_GUI.M with the given input arguments.
%
%      VOICE_GUI('Property','Value',...) creates a new VOICE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Voice_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Voice_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Voice_GUI

% Last Modified by GUIDE v2.5 08-Nov-2019 10:46:30
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Voice_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Voice_GUI_OutputFcn, ...
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


% --- Executes just before Voice_GUI is made visible.
function Voice_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Voice_GUI (see VARARGIN)

% Choose default command line output for Voice_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);






% UIWAIT makes Voice_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Voice_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nhandang.
function nhandang_Callback(hObject, eventdata, handles)
% hObject    handle to nhandang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over nhandang.
function nhandang_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to nhandang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in thuam.
function thuam_Callback(hObject, eventdata, handles)
% hObject    handle to thuam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('my_database.dat','-mat');
saiso = 12;
sound_id=length(data_save);
global fs;
fs = 16000;
set(handles.codeword, 'string', '');
        rec = audiorecorder(fs,8,1);
        rec_time = get(handles.rectime, 'string');
        rec_time=str2num(rec_time);
        disp('Bat dau thu am:');    
        record(rec,rec_time);
        while (isrecording(rec)==1)
           %disp('--> Dang ghi am...');
           set(handles.recordstate, 'string', 'Dang ghi am...');
           pause(0.4);
           set(handles.recordstate, 'string', 'Dang ghi am..');
        end
        set(handles.recordstate, 'string', 'Thu âm xong!!');
        data_rec = getaudiodata(rec);
        %data_rec = data_rec/abs(max(data_rec));
        data_plot = data_rec;
        %data_plot = bandpass(data_plot,[50;3000],fs);
        data_plot = filter([1 -0.9375], 1, data_plot);
        data_tach = endcut(data_plot);
        data_mfcc = mfcc(data_tach, fs);
        %axes(handles.axes2);
        distmin = inf;
        k1 = 0;     
        for i=1:sound_id
          d = disteu(data_mfcc, data_save{i,1});
          dist = sum(min(d,[],2)) / size(d,1);
          message=strcat('For file #',num2str(i),' Dist : ',num2str(dist));
          disp(message);       
          if dist < distmin
            distmin = dist;
            k1 = i;
          end
        end
      
      if distmin < saiso
         min_index = k1;
         set(handles.codeword, 'string', data_save{min_index,3});
         
      else
         msgbox('Khong nhan dang duoc');
      end
      data_preem = filter([1 -0.9375], 1, data_plot);
      plot(data_plot);
      hold on
      plot(data_preem);
      xlabel('So mau') 
      title('Tin hieu tieng noi') 
      legend ('Truoc Pre-emphasis','Sau Pre-emphasis')
      hold off

        



function codeword_Callback(hObject, eventdata, handles)
% hObject    handle to codeword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of codeword as text
%        str2double(get(hObject,'String')) returns contents of codeword as a double


% --- Executes during object creation, after setting all properties.
function codeword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to codeword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rectime_Callback(hObject, eventdata, handles)
% hObject    handle to rectime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rectime as text
%        str2double(get(hObject,'String')) returns contents of rectime as a double


% --- Executes during object creation, after setting all properties.
function rectime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rectime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function recordstate_Callback(hObject, eventdata, handles)
% hObject    handle to recordstate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recordstate as text
%        str2double(get(hObject,'String')) returns contents of recordstate as a double


% --- Executes during object creation, after setting all properties.
function recordstate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordstate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
