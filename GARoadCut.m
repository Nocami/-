function varargout = GARoadCut(varargin)
% GAROADCUT MATLAB code for GARoadCut.fig
%      GAROADCUT, by itself, creates a new GAROADCUT or raises the existing
%      singleton*.
%
%      H = GAROADCUT returns the handle to a new GAROADCUT or the handle to
%      the existing singleton*.
%
%      GAROADCUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAROADCUT.M with the given input arguments.
%
%      GAROADCUT('Property','Value',...) creates a new GAROADCUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GARoadCut_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GARoadCut_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GARoadCut

% Last Modified by GUIDE v2.5 02-Jan-2019 16:07:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GARoadCut_OpeningFcn, ...
                   'gui_OutputFcn',  @GARoadCut_OutputFcn, ...
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


% --- Executes just before GARoadCut is made visible.
function GARoadCut_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GARoadCut (see VARARGIN)

% Choose default command line output for GARoadCut
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GARoadCut wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GARoadCut_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SelectPhoto_button.
function SelectPhoto_button_Callback(hObject, eventdata, handles)
% hObject    handle to SelectPhoto_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global chrom oldpop fitness lchrom  popsize cross_rate mutation_rate yuzhisum
global maxgen  m n fit gen yuzhi A B C oldpop1 popsize1 b b1 fitness1 yuzhi1
axis off  %%�ر���������ʾ    
[filename,pathname] =uigetfile({'*.jpeg';'*.bmp';'*.jpg';'*.png';'*.*'},'ѡ��ͼƬ');
str=[pathname filename];  
%��ͼ��  
A=imread(str);  %�����·ͼ��
%��axes1�ľ�� ����axes1�Ĳ���  
axes(handles.OriginPhoto);  
%%��axes1����ʾ ͼ��  
imshow(A);  

% --- Executes on button press in RUN_button.
function RUN_button_Callback(hObject, eventdata, handles)
% hObject    handle to RUN_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global chrom oldpop fitness lchrom  popsize cross_rate mutation_rate yuzhisum
global maxgen  m n fit gen yuzhi A B C oldpop1 popsize1 b b1 fitness1 yuzhi1 result bestyuzhi


bbox=msgbox('����ʹ�øĽ��㷨����ͼ��ָ���Ժ�......');
 
%ͼ������
B=rgb2gray(A);      %��RGBͼ��ת���ɻҶ�ͼ��
C=imresize(B,0.1);    %�������ͼ����С
data_1_str = get(handles.lchromNum, 'string');
lchrom = str2num(data_1_str);%Ⱦɫ�峤��
data_2_str = get(handles.popsizeNum, 'string');      
popsize=str2num(data_2_str);    %��Ⱥ��С
data_3_str = get(handles.crossNum, 'string');
cross_rate=str2double(data_3_str);      %�ӽ�����
data_4_str = get(handles.mutationNum, 'string');
mutation_rate=str2double(data_4_str);    %�������
%������
data_5_str = get(handles.maxgenNum, 'string');
maxgen=str2num(data_5_str);            
[m,n]=size(C);

%��ʼ��Ⱥ
initpop;   
%�Ŵ�����
tic;
for gen=1:maxgen
    fitness_order; %������Ӧ��ֵ������
    select; %ѡ�����
    crossover;  %����
    mutation;  %����  
end
set(handles.edit9, 'string', toc);%��ʱ
findresult; %ͼ��ָ���
axes(handles.CuttedPhoto);  
imshow(C);  
%%%%%%�������������%%%%%%
set(handles.edit8, 'string', result);%������ֵ

axes(handles.Best);  
gen=1:maxgen;
plot(gen,fit(1,gen)); 

axes(handles.BestYuzhi);  
plot(gen,yuzhi(1,gen));
axes(handles.photoyuzhi);  
plot(gen,bestyuzhi(1,gen));

close(bbox);







function popsizeNum_Callback(hObject, eventdata, handles)
% hObject    handle to popsizeNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popsizeNum as text
%        str2double(get(hObject,'String')) returns contents of popsizeNum as a double


% --- Executes during object creation, after setting all properties.
function popsizeNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popsizeNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lchromNum_Callback(hObject, eventdata, handles)
% hObject    handle to lchromNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lchromNum as text
%        str2double(get(hObject,'String')) returns contents of lchromNum as a double


% --- Executes during object creation, after setting all properties.
function lchromNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lchromNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crossNum_Callback(hObject, eventdata, handles)
% hObject    handle to crossNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crossNum as text
%        str2double(get(hObject,'String')) returns contents of crossNum as a double


% --- Executes during object creation, after setting all properties.
function crossNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crossNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mutationNum_Callback(hObject, eventdata, handles)
% hObject    handle to mutationNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mutationNum as text
%        str2double(get(hObject,'String')) returns contents of mutationNum as a double


% --- Executes during object creation, after setting all properties.
function mutationNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mutationNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxgenNum_Callback(hObject, eventdata, handles)
% hObject    handle to maxgenNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxgenNum as text
%        str2double(get(hObject,'String')) returns contents of maxgenNum as a double


% --- Executes during object creation, after setting all properties.
function maxgenNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxgenNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RUN_button2.
function RUN_button2_Callback(hObject, eventdata, handles)
% hObject    handle to RUN_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global chrom oldpop fitness lchrom  popsize cross_rate mutation_rate yuzhisum
global maxgen  m n fit gen yuzhi A B C oldpop1 popsize1 b b1 fitness1 yuzhi1 result bestyuzhi

bbox=msgbox('����ʹ����ͨ�㷨����ͼ��ָ���Ժ�......');
 
%ͼ������
B=rgb2gray(A);      %��RGBͼ��ת���ɻҶ�ͼ��
C=imresize(B,0.1);    %�������ͼ����С
data_1_str = get(handles.lchromNum, 'string');
lchrom = str2num(data_1_str);%Ⱦɫ�峤��
data_2_str = get(handles.popsizeNum, 'string');      
popsize=str2num(data_2_str);    %��Ⱥ��С
data_3_str = get(handles.crossNum, 'string');
cross_rate=str2double(data_3_str);      %�ӽ�����
data_4_str = get(handles.mutationNum, 'string');
mutation_rate=str2double(data_4_str);    %�������
%������
data_5_str = get(handles.maxgenNum, 'string');
maxgen=str2num(data_5_str);            
[m,n]=size(C);

%��ʼ��Ⱥ
initpop;   
%�Ŵ�����
tic;
for gen=1:maxgen
    fitness_order2; %������Ӧ��ֵ
    select2; %ѡ�����
    crossover2;  %����
    mutation2;  %����  
end
set(handles.edit9, 'string', toc);%��ʱ
findresult; %ͼ��ָ���
axes(handles.CuttedPhoto);  
imshow(C);  
%%%%%%�������������%%%%%%
set(handles.edit8, 'string', result);%������ֵ
axes(handles.Best);  
gen=1:maxgen;
plot(gen,fit(1,gen)); 

axes(handles.BestYuzhi);  
plot(gen,yuzhi(1,gen));
axes(handles.photoyuzhi); 
plot(gen,bestyuzhi(1,gen));

close(bbox);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function OriginPhoto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OriginPhoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off  %%�ر���������ʾ 
% Hint: place code in OpeningFcn to populate OriginPhoto


% --- Executes during object creation, after setting all properties.
function CuttedPhoto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CuttedPhoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off  %%�ر���������ʾ 
% Hint: place code in OpeningFcn to populate CuttedPhoto


% --- Executes during object creation, after setting all properties.
function Best_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Best (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off  %%�ر���������ʾ 
% Hint: place code in OpeningFcn to populate Best


% --- Executes during object creation, after setting all properties.
function photoyuzhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to photoyuzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off  %%�ر���������ʾ 
% Hint: place code in OpeningFcn to populate photoyuzhi


% --- Executes during object creation, after setting all properties.
function BestYuzhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BestYuzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off  %%�ر���������ʾ 
% Hint: place code in OpeningFcn to populate BestYuzhi
