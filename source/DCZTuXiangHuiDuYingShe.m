%% �����---ͼ��Ҷ�ӳ��
% * ����      ����Ҫʵ��ͼ����͵ĻҶ�ӳ��
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[9/5/2017]  
%%

%%
%
% <<main.bmp>>
%

%% ������
% *�����κ��޸�*
function varargout = DCZTuXiangHuiDuYingShe(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCZTuXiangHuiDuYingShe_OpeningFcn, ...
                   'gui_OutputFcn',  @DCZTuXiangHuiDuYingShe_OutputFcn, ...
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
function DCZTuXiangHuiDuYingShe_OpeningFcn(hObject, eventdata, handles, ... 
                                            varargin)
% ȫ�ֱ���
    handles.img_str=' ';        % ͼ���ַ
    handles.img=0;              % ͼ������
    handles.img_width=0;        % ͼ���
    handles.img_hight=0;        % ͼ���    
% ����
    axes(handles.axes2);
    axis([0 256 0 256]);
    set(handles.select,'enable','off');
    set(handles.edit_YRK,'enable','off');
    set(handles.edit_XC,'enable','off');
    set(handles.PB_ReNewImg,'enable','off');
    set(handles.PB_SaveImg,'enable','off');
    set(handles.PB_RecoverImg,'enable','off');
    
% Choose default command line output for DCZTuXiangHuiDuYingShe
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes DCZTuXiangHuiDuYingShe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% �������
function DCZTuXiangHuiDuYingShe_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
%varargout{1} = handles.output;
%


%%������ͼ��
function PB_LoadImg_Callback(hObject, eventdata, handles)
%������ͼ��
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index              
   % ���ݳ�ʼ��
        str=[pname fname]; 
        handles.img_str=str;        % ͼ���ַ
        handles.img=imread(str);    % ͼ������
        handles.img_old=handles.img;% Դͼ��
        [hight,width]=size(handles.img);
        handles.img_width=width;    % ͼ���
        handles.img_hight=hight;    % ͼ���      
   % ��ʹ��
        set(handles.select,'enable','on');
        set(handles.edit_YRK,'enable','on');
        set(handles.edit_XC,'enable','on');
        set(handles.PB_ReNewImg,'enable','on');
        set(handles.PB_SaveImg,'enable','on');
        set(handles.PB_RecoverImg,'enable','on');        
        set(handles.select,'String',{'���ӳ��','�ֲ�ӳ��','����ӳ��',...
            '����ӳ��','��תӳ��','�ֶ�ӳ��','��̬��Χѹ��','٤��У��'});
   % ���½ṹ������
        guidata(hObject, handles)
        % ��ʾͼ��
        axes(handles.axes1);
        imshow(str); 
end


%% ����ͼ��
function PB_SaveImg_Callback(hObject, eventdata, handles)
% ����ͼ��
    [FileName,PathName] =uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';
              '*.*','All Files' },'����ͼ��',...
              'C:\Work\newfile.jpg');
    if FileName==0
        return;
    else
        h=getframe(handles.axes1);
        imwrite(h.cdata,[PathName,FileName]);
    end


%% �ָ�ԭͼ
function PB_RecoverImg_Callback(hObject, eventdata, handles)
% �ָ�ԭͼ
    handles.img=handles.img_old;
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(uint8(handles.img));
    
    
%% ���ӳ�� 
function handles=hengDengYingShe(hObject,handles)
% ���ӳ��    
% ������ʾ
    x=0:256;                                
    k=get(handles.edit_YRK,'value');           
    y=k*x;
    axes(handles.axes2);
    plot(x,y);
    axis([0 256 0 256]);
% ͼ����ʾ  
    handles.img=k.*handles.img;                 
%%
% 
% <<���ӳ��.bmp>>
% 

%% �ֲ�ӳ�� 
function handles=juBuYingShe(hObject,handles)
% �ֲ�ӳ�� 
% �����������
    x0=get(handles.edit_XC,'value');        % X 
    y0=get(handles.edit_YRK,'value');       % Y
% �߽���
    if (x0>=256) || (y0>=256)               
        load chirp                          % ����
        sound(y,Fs);
        hs=msgbox('�����������ָ����Χ��','����','warn');
        ht=findobj(hs,'type','text');
        set(ht,'FontSize',11);
        uiwait(hs);                         % �ȴ�ȷ��
        x0=0;
        y0=0;
        set(handles.edit_XC,'string',0,'value',0);
        set(handles.edit_YRK,'string',0,'value',0);
        guidata(hObject,handles);
    end
% ������ʾ
    x=0:1:256;                              
    y=y0*(x<x0)+(y0+(x-x0)./(256-x0).*(256-y0)).*(x>=x0);
    axes(handles.axes2);
    plot(x,y);
    axis([0 256 0 256]);
    text(x0,y0,['(',num2str(x0),',',num2str(y0),')'],'color','b'); 
% ͼ����ʾ
    handles.img(handles.img<=x0)=y0;        
    handles.img(handles.img>x0)=y0+(256-y0)/(256-x0)*(handles.img(handles.img>x0)-x0);
%%
% 
% <<�ֲ�ӳ��.bmp>>
%


%% ����ӳ��
function handles=junYunYingShe(hObject,handles)
% ����ӳ��
% ������ʾ
    x=0:1:256;
    y=256/85.*x.*(x<85)+(0:256).*(x==85);
    y=y+256/85.*(x-85).*(x>85 & x<170)+(0:256).*(x==85);
    y=y+256/85.*(x-170).*(x>170 & x<256)+(0:256).*(x==170);
    axes(handles.axes2);
    plot(x,y);
    axis([0 256 0 256]);    
% ͼ����ʾ
    a=get(handles.edit_XC,'value');        
    b=get(handles.edit_YRK,'value'); 
    I=handles.img;
    if b==0 && a==1
        I((I<85) | (I>85 & I<170) | (I>170))=256/85.*I((I<85) | ...
            (I>85 & I<170) | (I>170));
        handles.img=I;
    else if b==1&& a==0
            I(I<85)=256/85.*I(I<85);
            I(I>85 & I<170)=256/85.*I(I>85 & I<170);
            I(I>170)=256/85.*I(I>170);
            handles.img=I;
        else
            load chirp                          % ����
            sound(y,Fs);
            hs=msgbox('����������Ϸ���','����','warn');
            ht=findobj(hs,'type','text');
            set(ht,'FontSize',11);
            uiwait(hs);                         % �ȴ�ȷ��
            set(handles.edit_XC,'string',0,'value',0);
            set(handles.edit_YRK,'string',0,'value',0);
        end
    end
%%
% 
% <<����ӳ��.bmp>>
%

    
%% ����ӳ��
function handles=fanChaYingShe(hObject,handles)
% ����ӳ��
% ������ʾ
    R1=get(handles.edit_XC,'value');
    R2=get(handles.edit_YRK,'value');
    x=0:1:256;
    y=x.^R1.*(x<128)+(128+(x-128).^R2).*(128<x & x<256);
    axes(handles.axes2);
    plot(x,y);
% ͼ����ʾ
    I=handles.img;
    I(I<128)=I(I<128).^R1;
    I(128<I & I<256)=128+(I(128<I & I<256)-128).^R2;
    handles.img=I;
%%
% 
% <<����ӳ��.bmp>>
% 
    
    
%% ��תӳ��
function handles=fanZhuanYingShe(hObject,handles)
% ��תӳ��
% ������ʾ
    x=0:1:256;
    y=256.*(x==0)+(256-x).*(x>=1);
    axes(handles.axes2);
    plot(x,y);
% ͼ����ʾ
    I=handles.img;
    I=256-I;
    handles.img=I;
%%
% 
% <<��תӳ��.bmp>>
%    

%% �ֶ�ӳ��
function handles=fenDuanYingShe(hObject,handles)
% �ֶ�ӳ��
% ��ȡ�������
    % ��һ����
    str1=get(handles.edit_XC,'String');
    % ��ȡ�ַ���1�ĳ���
    LEN1=length(str1);
    % �����ո���±�
    len1=regexp(str1,',');
    % ��ȡ����
    X1=str2double(str1(1:len1-1));
    Y1=str2double(str1(len1+1:LEN1));
    % �ڶ�����
    str2=get(handles.edit_YRK,'String');
    % ��ȡ�ַ���1�ĳ���
    LEN2=length(str2);
    % �����ո���±�
    len2=regexp(str2,',');
    % ��ȡ����
    X2=str2double(str2(1:len2-1));
    Y2=str2double(str2(len2+1:LEN2));    
% ������ʾ
    x=0:1:256;
    y=(Y1./X1).*x.*(x<=X1)+...
        (Y1+(Y2-Y1)./(X2-X1).*(x-X1)).*(X1<x & x<=X2)+...
        (Y2+(256-Y2)/(256-X2).*(x-X2)).*(X2<x);        
    axes(handles.axes2);
    plot(x,y);% ���ƺ��� 
    axis([0 256 0 256]);% ��������ϵ��ʾ��Χ
    text(X1,Y1,['(',num2str(X1),',',num2str(Y1),')'],'color','b'); 
    text(X2,Y2,['(',num2str(X2),',',num2str(Y2),')'],'color','b'); 
% ͼ����ʾ
    I=handles.img;
    I(I<X1)=(Y1/X1)*I(I<X1);
    I(X1<I & I<X2)=(Y2-Y1)/(X2-X1).*(I(X1<I & I<X2)-X1);
    I(X2<I)=(256-Y2)/(256-X2).*(I(X2<I)-X2);
    handles.img=I;
%%
% 
% <<�ֶ�ӳ��.bmp>>
%      

%% ��̬��Χѹ��
function handles=dongTaiFanWeiYaSuo(hObject,handles)
% ��̬��Χѹ��
% ������ز���
    C=str2double(get(handles.edit_XC,'String'));
% ������ʾ
    x=0:1:256;
    y=C.*log(1+x);   
    axis([0 256 0 256]);% ��������ϵ��ʾ��Χ
    axes(handles.axes2);
    plot(x,y);
% ͼ����ʾ
    I=double(handles.img);
    I=C.*log(1+I);
    handles.img=I;
%%
% 
% <<��̬��Χѹ��.bmp>>
%   

%% ٤��У��   
function handles=gaMaJiaoZheng(hObject,handles)
% ٤��У��
% ������ز���
    C=str2double(get(handles.edit_XC,'String'));
    r=str2double(get(handles.edit_YRK,'String'));
% ������ʾ
    x=0:1:256;
    y=C.*x.^r;   
    axis([0 256 0 256]);% ��������ϵ��ʾ��Χ
    axes(handles.axes2);
    plot(x,y);
% ͼ����ʾ
    I=double(handles.img);
    I=C.*I.^r;
    handles.img=I;
%%
% 
% <<..\٤��У��.bmp>>
%


%% ����ͼ��
function PB_ReNewImg_Callback(hObject, eventdata, handles)
%   1   '���ӳ��'              5   '��תӳ��'
%   2   '�ֲ�ӳ��'              6   '�ֶ�ӳ��'
%   3   '����ӳ��'              7   '��̬��Χѹ��'
%   4   '����ӳ��'              8   '٤��У��'
% ѡ��ӳ�亯��
switch get(handles.select,'value')
    case 1      % ���ӳ��    
        handles=hengDengYingShe(hObject,handles); 
    case 2      % �ֲ�ӳ��
        handles=juBuYingShe(hObject,handles);
    case 3      % ����ӳ��
        handles=junYunYingShe(hObject,handles);   
    case 4      % ����ӳ��
        handles=fanChaYingShe(hObject,handles);
    case 5      % ��תӳ��
        handles=fanZhuanYingShe(hObject,handles);
    case 6      % �ֶ�ӳ��
        handles=fenDuanYingShe(hObject,handles);
    case 7      % ��̬��Χѹ��
        handles=dongTaiFanWeiYaSuo(hObject,handles);
    case 8      % ٤��У��
        handles=gaMaJiaoZheng(hObject,handles);
end
% ���½ṹ������
guidata(hObject, handles);
% ����ͼ����ʾ����
axes(handles.axes1);        
% ��ʾͼ��
imshow(uint8(handles.img));
% ����δ��������ָ�ԭͼ 
if ~get(handles.radiobutton2,'value')
    handles.img=handles.img_old;
    guidata(hObject,handles);
end


%% ѡ��ӳ�亯��
function select_Callback(hObject, eventdata, handles)
% ӳ�亯����
%   1   '���ӳ��'              5   '��תӳ��'
%   2   '�ֲ�ӳ��'              6   '�ֶ�ӳ��'
%   3   '����ӳ��'              7   '��̬��Χѹ��'
%   4   '����ӳ��'              8   '٤��У��'
% ��ʾ
load chirp                          % ����
sound(y,Fs);
switch get(hObject,'value')
    case 1
        set(handles.edit_XC,'enable','off');                    % �������
        set(handles.edit_YRK,'string','K','enable','on');
        hs=msgbox({'���ӳ��' '��Ҫ�������K!'},'��ʾ','help');         
    case 2
        set(handles.edit_XC,'string','x0','enable','on');       % �������
        set(handles.edit_YRK,'string','y0','enable','on');        
        hs=msgbox({'�ֲ�ӳ��' '��Ҫ�������:(x0,y0)'},'��ʾ','help');  
    case 3
        set(handles.edit_XC,'enable','on');                     % �������
        set(handles.edit_YRK,'enable','on');
        hs=msgbox({'����ӳ��' '�޲�������'},'��ʾ','help');    
    case 4
        set(handles.edit_XC,'string','R1','enable','on');       % �������
        set(handles.edit_YRK,'string','R2','enable','on');
        hs=msgbox({'����ӳ��' '���������: R1, R2' '�����У���δ���'}...
            ,'��ʾ','help'); 
    case 5
        set(handles.edit_XC,'enable','off');                    % �������
        set(handles.edit_YRK,'enable','off');
        hs=msgbox({'��תӳ��' '����Ҫ���������'},'��ʾ','help');   
    case 6
        set(handles.edit_XC,'string','X1,Y1','enable','on');    % �������
        set(handles.edit_YRK,'string','X2,Y2','enable','on');
        hs=msgbox({'�ֶ�ӳ��' '��������������: X1,Y1  X2,Y2'}...
            ,'��ʾ','help');    
    case 7
        set(handles.edit_XC,'string','C','enable','on');        % �������
        set(handles.edit_YRK,'enable','off');
        hs=msgbox({'��̬��Χѹ��' '���������C!'},'��ʾ','help');
    case 8
        set(handles.edit_XC,'string','C','enable','on');        % �������
        set(handles.edit_YRK,'string','r','enable','on');
        hs=msgbox({'٤��У��' '��������������: C,r'}...
            ,'��ʾ','help');         
end
ht=findobj(hs,'type','text');
set(ht,'FontSize',11);
uiwait(hs);     % �ȴ�ȷ��  
% ����δ��������ָ�ԭͼ 
if ~get(handles.radiobutton2,'value')
    handles.img=handles.img_old;
    guidata(hObject,handles);
    % ����ͼ����ʾ����
    axes(handles.axes1);        
    % ��ʾͼ��
    imshow(uint8(handles.img));
end


function edit_YRK_Callback(hObject, eventdata, handles)
% ��Y����ֵתΪdouble����
YR=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',YR);
% ���½ṹ������
guidata(hObject, handles);

function edit_YRK_CreateFcn(hObject, eventdata, handles)
set(hObject,'value',1);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_XC_Callback(hObject, eventdata, handles)
% ��Y����ֵתΪdouble����
XC=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',XC);
% ���½ṹ������
guidata(hObject, handles);

function edit_XC_CreateFcn(hObject, eventdata, handles)
set(hObject,'value',1);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end