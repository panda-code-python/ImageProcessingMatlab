%% ģ�����---ģ������
% * ����      ����Ҫʵ�ֶ�ͼ���ģ������
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[9/5/2017]  
%%

%%
%
% <<main.bmp>>
%


%% ������
% *�����κ��޸�*
function varargout = MBCZMoBanYunSuan(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MBCZMoBanYunSuan_OpeningFcn, ...
                   'gui_OutputFcn',  @MBCZMoBanYunSuan_OutputFcn, ...
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


%% ��ʼ����
% *��س�ʼ��*
function MBCZMoBanYunSuan_OpeningFcn(hObject, eventdata, handles, varargin)
% ȫ�ֱ���
    handles.img_str=' ';        % ͼ���ַ
    handles.img=0;              % ͼ������
    handles.img_width=0;        % ͼ���
    handles.img_height=0;       % ͼ���    
% ����ģ���ֵ
    temp=ones(11);
    set(handles.uitable1,'data',temp,'ColumnWidth',{20});
   % ��ʹ��
        set(handles.recover,'enable','off');
        set(handles.usePlate,'enable','off');
        set(handles.clearPlate,'enable','off');
        set(handles.edit1,'enable','off');
        
% Choose default command line output for MBCZMoBanYunSuan
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes MBCZMoBanYunSuan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% �������
function MBCZMoBanYunSuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;


%% ����ģ���С
function edit1_Callback(hObject, eventdata, handles)
% ģ���С
    N=str2double(get(hObject,'String'));
    M=zeros(N);
    % ���µ�uitable1
    if N>11                                 % ģ�����Ϊ11x11
        load chirp                          % ����
        sound(y,Fs);
        hs=msgbox('ģ�����','����','warn');
        ht=findobj(hs,'type','text');
        set(ht,'FontSize',11);
        uiwait(hs);                         % �ȴ�ȷ��
        return ;
    else
        set(handles.uitable1,'Data',M);
        guidata(hObject,handles);
    end

    
%%  ʹ��ģ��
function usePlate_Callback(hObject, eventdata, handles)
% ʹ��ģ��
% ����ģ���С 
    N=str2double(get(handles.edit1,'String'));
% ����ģ������
    plate=get(handles.uitable1,'data');
% ����ͼ������
    dX=double(handles.img);
% ʹ��ģ������ͼ��
    for i=1:handles.img_width-N+1
       for j=1:handles.img_height-N+1
            temp=dX(i:i+(N-1),j:j+(N-1));   % ȡ��ͼ������ģ���Ӧ������
            wf=sum(sum(plate.*temp));       % �������
            M=sum(sum(plate));              % ��ģ���ϵ����
            g=wf/M;                         % ����ģ�����ĵ�Ҷ�ֵ 
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=g;  % ���Ҷ�ֵд��ͼ���Ӧ��λ��               
       end
    end  
% ���²���ʾͼ��
    handles.img=uint8(dX);
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(handles.img); 
        
        
%% ���ģ��
function clearPlate_Callback(hObject, eventdata, handles)
% ���ģ��
% ����ģ��Ϊ��ֵ
    temp=ones(11);
    set(handles.edit1,'String','11');
    set(handles.uitable1,'data',temp,'ColumnWidth',{20});
    guidata(hObject,handles);
    
    
%% ����ͼ��
function load_Callback(hObject, eventdata, handles)
% ����ͼ��
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index              
   % ���ݳ�ʼ��
        str=[pname fname]; 
        handles.img_str=str;        % ͼ���ַ
        handles.img=imread(str);    % ͼ������
        handles.img_old=handles.img;% Դͼ��
        [hight,width]=size(handles.img);
        handles.img_width=width;    % ͼ���
        handles.img_height=hight;   % ͼ���      
   % ��ʹ��
        set(handles.recover,'enable','on');
        set(handles.usePlate,'enable','on');
        set(handles.clearPlate,'enable','on');
        set(handles.edit1,'enable','on');
   % ���½ṹ������
        guidata(hObject, handles)
        % ��ʾͼ��
        axes(handles.axes1);
        imshow(str); 
end


%% �ָ�ͼ��
function recover_Callback(hObject, eventdata, handles)
% �ָ�ͼ��
% �ָ�ԭͼ
    handles.img=handles.img_old;
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(uint8(handles.img));

%% ���չʾ

%%
%
% <<test1.bmp>>
%    

%%
%
% <<test2.bmp>>
%  