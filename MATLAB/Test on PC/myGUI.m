function varargout = myGUI(varargin)
% MYGUI MATLAB code for myGUI.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myGUI

% Last Modified by GUIDE v2.5 01-Jan-2020 11:03:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @myGUI_OutputFcn, ...
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


% --- Executes just before myGUI is made visible.
function myGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myGUI (see VARARGIN)

% Choose default command line output for myGUI
handles.output = hObject;
clc
handles.playback=[];

guidata(hObject, handles);

% UIWAIT makes myGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = myGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
data_rec = evalin('base', 'data_rec');
m_pho = evalin('base', 'm_pho');
f = evalin('base', 'f');
data_emphasis = evalin('base', 'data_emphasis');
data_tach = evalin('base', 'data_tach');
data_mfcc = evalin('base', 'data_mfcc');
vector_vq = evalin('base', 'vector_vq');
min_index = evalin('base', 'min_index');
load('my_database.dat','-mat');  
switch get(handles.popupmenu1,'Value')   
    case 1
        plot(data_rec);
        hold on
        plot(data_emphasis);
        hold off
    case 2
        plot(data_tach);
    case 3
        plot(f,m_pho);
        xlabel('f(Hz)')
    case 4
        plot(data_mfcc);
        xlabel('So bang loc Mel')
    case 5
        cla
        plot(vector_vq);    
    case 6
        plot(vector_vq);   
        hold on
        plot(data_save{min_index,1},'k--','markersize',3);    
        hold off
        xlabel('So bang loc Mel');     
  otherwise
        end
        set(handles.axes1,'XColor','White');
        set(handles.axes1,'YColor','White');


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs       = str2num(get(handles.edit2, 'String'));
dur      = str2num(get(handles.edit3, 'String'));
centroid = str2num(get(handles.edit4, 'String'));
saiso    = str2num(get(handles.edit5, 'String'));
tick     = get(handles.checkbox1, 'value');
nguong   = str2num(get(handles.edit7, 'String'));
if (isempty(fs) || isempty(dur) || isempty(centroid) || isempty(saiso))
    msgbox('Missing value!!', 'Error','error');
else
assignin('base','fs',fs);
assignin('base','dur',dur);
assignin('base','centroid',centroid);
assignin('base','saiso',saiso);
assignin('base','tick',tick);
assignin('base','nguong',nguong);

rec = audiorecorder(fs,8,1);
set(handles.pro_text,'String','Bat dau thu am');
record(rec,dur);
        while (isrecording(rec)==1)
           set(handles.pro_text,'String','Dang ghi am..');
           pause(0.5);
        end
set(handles.pro_text,'String','Da thu am xong!!');

data_rec = getaudiodata(rec);
data_rec = data_rec/abs(max(data_rec));
assignin('base','data_rec',data_rec);
axes(handles.axes1);
plot(data_rec);
set(handles.axes1,'XColor','White');
set(handles.axes1,'YColor','White');

if (tick)
    data_emphasis = filter([1 -0.9375], 1, data_rec);
else
    data_emphasis = data_rec;
end
assignin('base','data_emphasis',data_emphasis);
data_tach = endcut(data_emphasis,128,nguong);
assignin('base','data_tach',data_tach);
data_mfcc = mfcc(data_tach, fs);
assignin('base','data_mfcc',data_mfcc);
vector_vq = vqlbg(data_mfcc,centroid);
assignin('base','vector_vq',vector_vq);

        m_pho = fft(data_tach);
        L = length(data_tach);
        m_pho = abs(m_pho/L);
        m_pho = m_pho(1:L/2+1);
        m_pho(2:end-1) = 2*m_pho(2:end-1);
        f = fs*(0:(L/2))/L;
        assignin('base','m_pho',m_pho);
        assignin('base','f',f);
        
load('my_database.dat','-mat');  
      sound_id=length(data_save);
      distmin = Inf;
      k1 = 0;
      
      for i=1:sound_id
        d = disteu(data_mfcc, data_save{i,1});
        dist = sum(min(d,[],2)) / size(d,1);
        message{i}=strcat('File #',num2str(i),': Khoang cach Euclid voi tu "',data_save{i,3},'" :', num2str(dist));
        set(handles.listbox1, 'String', message);
             
        if dist < distmin
          distmin = dist;
          k1 = i;
        end
      end
      min_index = k1;
      assignin('base','min_index',min_index);
      if distmin < saiso       
         dis = sprintf('Ban vua noi:"%s"\nKhop voi file so %d', data_save{min_index,3},min_index );
         set(handles.text9, 'String', dis);         
      else
         dis = sprintf('Tu khop nhat:"%s"\n', data_save{min_index,3});
         set(handles.text9, 'String', dis); 
         msgbox('Khong nhan dang duoc');
      end
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


        
        
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        


function pro_text_Callback(hObject, eventdata, handles)
% hObject    handle to pro_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pro_text as text
%        str2double(get(hObject,'String')) returns contents of pro_text as a double


% --- Executes during object creation, after setting all properties.
function pro_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pro_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs = evalin('base', 'fs');
data_rec = evalin('base', 'data_rec');
handles.playback = audioplayer(data_rec,fs);
play(handles.playback);
while (isplaying(handles.playback)==1)
    set(handles.pro_text,'String','Dang phat lai...');
    pause(0.5);
end
set(handles.pro_text,'String','Done!');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fs = evalin('base', 'fs');
data_tach = evalin('base', 'data_tach');
handles.playback = audioplayer(data_tach,fs);
play(handles.playback);
while (isplaying(handles.playback)==1)
    set(handles.pro_text,'String','Dang phat lai...');
    pause(0.5);
end
set(handles.pro_text,'String','Done!');
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('my_database.dat','-mat'); 
min_index = evalin('base', 'min_index');
fs = evalin('base', 'fs');
handles.playback = audioplayer(data_save{min_index,5},fs);
play(handles.playback);
while (isplaying(handles.playback)==1)
    set(handles.pro_text,'String','Dang phat lai...');
    pause(0.5);
end
set(handles.pro_text,'String','Done!');



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_rec = evalin('base', 'data_rec');
fs       = str2num(get(handles.edit2, 'String'));
dur      = str2num(get(handles.edit3, 'String'));
centroid = str2num(get(handles.edit4, 'String'));
saiso    = str2num(get(handles.edit5, 'String'));
tick     = get(handles.checkbox1, 'value');
nguong   = str2num(get(handles.edit7, 'String'));

min_index = evalin('base','min_index');
load('my_database.dat','-mat');



if (isempty(fs) || isempty(dur) || isempty(centroid) || isempty(saiso) || isempty(nguong))
    msgbox('Missing value!!', 'Error','error');
else
assignin('base','fs',fs);
assignin('base','dur',dur);
assignin('base','centroid',centroid);
assignin('base','saiso',saiso);
assignin('base','tick',tick);
assignin('base','nguong',nguong);
if (tick)
    data_emphasis = filter([1 -0.9375], 1, data_rec);
else
    data_emphasis = data_rec;
end
assignin('base','data_emphasis',data_emphasis);
data_tach = endcut(data_emphasis,128,nguong);
assignin('base','data_tach',data_tach);
data_mfcc = mfcc(data_tach, fs);
assignin('base','data_mfcc',data_mfcc);
vector_vq = vqlbg(data_mfcc,centroid);
assignin('base','vector_vq',vector_vq);

        m_pho = fft(data_tach);
        L = length(data_tach);
        m_pho = abs(m_pho/L);
        m_pho = m_pho(1:L/2+1);
        m_pho(2:end-1) = 2*m_pho(2:end-1);
        f = fs*(0:(L/2))/L;
        assignin('base','m_pho',m_pho);
        assignin('base','f',f);
        
        switch get(handles.popupmenu1,'Value')   
    case 1
        plot(data_rec);
        hold on
        plot(data_emphasis);
        hold off
    case 2
        plot(data_tach);
    case 3
        plot(f,m_pho);
        xlabel('f(Hz)')
    case 4
        plot(data_mfcc);
        xlabel('So bang loc Mel')
    case 5
       cla
        plot(vector_vq); 
        xlabel('So bang loc Mel');
    case 6
        plot(vector_vq);   
        hold on
        plot(data_save{min_index,1},'k--','markersize',3);    
        hold off
        xlabel('So bang loc Mel'); 
  otherwise
        end
        set(handles.axes1,'XColor','White');
        set(handles.axes1,'YColor','White');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton6.
function pushbutton6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
