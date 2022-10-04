function varargout = interface0(varargin)
%INTERFACE0 M-file for interface0.fig
%      INTERFACE0, by itself, creates a new INTERFACE0 or raises the existing
%      singleton*.
%
%      H = INTERFACE0 returns the handle to a new INTERFACE0 or the handle to
%      the existing singleton*.
%
%      INTERFACE0('Property','Value',...) creates a new INTERFACE0 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interface0_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACE0('CALLBACK') and INTERFACE0('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACE0.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface0

% Last Modified by GUIDE v2.5 17-Apr-2021 05:12:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface0_OpeningFcn, ...
                   'gui_OutputFcn',  @interface0_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before interface0 is made visible.
function interface0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interface0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface0_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 if(get(handles.pushbutton1,'value')==1)
     set(inter3,'visible','on');
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.pushbutton2,'value')==1) 
    S = get(handles.edit4, 'String'); %lire la valeur de l edit 
    if isempty(S) %si l'utilisateur n'a pas tapé le nom d'un fichier on le donne la possibilité de l'extraire apartir de sa machine
       [fileName, pathname] = uigetfile('*.txt');  %browse 
       file=strcat(pathname,fileName);  %concatener le chemin et le nom de fichier 
    else   % si l'utilisateur à deja taper le nom de son fichier 
      file = S; 
    end
     
     EchFile= fopen(file , 'r'); %ouvrir le fichier des echantillons en mode lecture 
     ech = fscanf(EchFile ,'%f\n'); %charger les echantillons dans la variable ech 
     fclose (EchFile);  %fermer le fihcier des echantillons 
     set(handles.edit4,'string',file);
       % FFT MATLAB 
       FFT =fopen('C:\Users\Abir\Desktop\miniprojet2\fftm.txt','w');
       fprintf(FFT,'%f\t%f\n',fft(ech)); %remplir le fichier par les valeurs o de la fft 
       axes(handles.axes2);      %pointer sur l'axes 2
       FFTmatlab=fftshift(abs(fft(ech)));  %calcul de la fft de matlab 
       plot(FFTmatlab);    %dessiner la fft matlab 
       grid;
       %definir les noms des axes 
       xlabel ('frequence');
       ylabel ('amplitude');
       
       
       % afficher les valeurs de la FFT sur le listbox 
       set(handles.listbox1,'string',FFTmatlab);
       %calcul des grandeurs de signal 
       N=length(FFTmatlab);
       moyenne=mean(FFTmatlab);
       ma=max(FFTmatlab);
       mi=min(FFTmatlab);
 
       %Affichage de grandeurs : 
       set(handles.text31,'string',moyenne);
       set(handles.text35,'string',ma);
       set(handles.text37,'string',mi);
       
       
       % FFT C++
        open 'C:\Users\Abir\Desktop\miniprojet2\miniprojet2.exe' ;
        pause(0.3);
        filecpp='C:\Users\Abir\Desktop\miniprojet2\FFTcpp.txt';
        FFTCpp=load(filecpp);
        FFTR=FFTCpp(:,1);  % charger les reels de la FFT calculé par C++
        FFTI=FFTCpp(:,2);  % charger les imaginaire de la FFT calculé par C++
        FFTC=FFTR + i*FFTI;% constitué le signal 
        axes(handles.axes3);%pointer sur l'axe de la partie C++
        plot(fftshift(abs(FFTC)));%dessiner l'allure de la FFT
        grid



        %nommer les axes 
        xlabel ('frequence');
        ylabel ('amplitude');
        %afficher les valeurs de la FFT de C++
        set(handles.listbox2,'string',fftshift(abs(FFTC)));
        %calculer les grandeurs de la FFT 
        moyenneC=mean(fftshift(abs(FFTC)));
        maC=max(fftshift(abs(FFTC)));
        miC=min(fftshift(abs(FFTC)));
 
       %Affichage les grandeurs : 
       set(handles.text25,'string',moyenneC);
       set(handles.text41,'string',maC);
       set(handles.text39,'string',miC);
        
end
 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.pushbutton5,'value')==1)
     set(P1,'visible','on');
 end
