%% �����---����任
% * ����      ��
% *ʵ��ͼ�������任����Ҫ����ת��ƽ�ƣ����������񣬼������ֱ任����Ӧ����*
% *��ʵ�ַ������ƣ�����δ���*
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[4/5/2017]  


%%
%
% <<main.bmp>>
%


%% ������
% *�����κ��޸�*
function varargout = DCZZuoBiaoBianHuan(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCZZuoBiaoBianHuan_OpeningFcn, ...
                   'gui_OutputFcn',  @DCZZuoBiaoBianHuan_OutputFcn, ...
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


%% ��ʼ����
% *��س�ʼ��*
function DCZZuoBiaoBianHuan_OpeningFcn(hObject, eventdata, handles, varargin)
% ȫ�ֱ���
    handles.img_str=0;      % ͼ���ַ
    handles.img=0;          % ͼ������
    handles.img_width=0;    % ͼ���
    handles.img_hight=0;    % ͼ���
% �򿪲���ʾԭͼ��
    axes(handles.axes1);
    str=' ';
    % ͼ���ɲ�������
    if nargin ==2
        if ischar(varargin{2})
        % ��ʾͼ��
        str=varargin{2};
        end
    % ���´�ͼ��
    else
        % ��ʾ
            load chirp   % ����
            sound(y,Fs);
            hs=msgbox('ͼƬδ���أ�','֪ͨ','warn');
            ht=findobj(hs,'type','text');
            set(ht,'FontSize',11);
            % �ȴ�ȷ��
            uiwait(hs);
    end
    % ��ʾԭͼ��
    if str~=' '
        imshow(str);
        % ���ݳ�ʼ��
        handles.img_str=str;        % ͼ���ַ
        handles.img=imread(str);    % ͼ������
        [hight,width]=size(handles.img);
        handles.img_width=width;    % ͼ���
        handles.img_hight=hight;    % ͼ���
        set(handles.slider1,'Max',1000);
        set(handles.slider1,'value',1000);
    else % δ����ͼ�񣬹ر�ʹ��
        set(handles.PB_BaoCunTuXiang,'enable','off');
        set(handles.RB_BianHuanJiLian,'enable','off');
        set(handles.edit_XuanZhuan,'enable','off');
        set(handles.edit_X,'enable','off');
        set(handles.edit_Y,'enable','off');
        set(handles.edit_SuoFang,'enable','off');
        set(handles.pushbutton3,'enable','off');
        set(handles.pushbutton4,'enable','off');
        set(handles.pushbutton5,'enable','off');
        set(handles.pushbutton6,'enable','off');
        set(handles.pushbutton9,'enable','off');
        set(handles.pushbutton10,'enable','off');
    end
% Choose default command line output for DCZZuoBiaoBianHuan
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes DCZZuoBiaoBianHuan wait for user response (see UIRESUME)
% uiwait(handles.DCZZuoBiaoBianHuan);


%% �������
function DCZZuoBiaoBianHuan_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% ����ͼ��
function PB_JiaZaiTuXiang_Callback(hObject, eventdata, handles)
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index              
   % ���ݳ�ʼ��
        str=[pname fname]; 
        handles.img_str=str;        % ͼ���ַ
        handles.img=imread(str);    % ͼ������
        [hight,width]=size(handles.img);
        handles.img_width=width;    % ͼ���
        handles.img_hight=hight;    % ͼ���
        set(handles.slider1,'Max',hight);
        set(handles.slider1,'value',hight);        
   % ״̬�ָ�
        set(handles.edit_XuanZhuan,'String','0');
        set(handles.edit_X,'String','0');
        set(handles.edit_Y,'String','0');
        set(handles.edit_SuoFang,'String','0');
        set(handles.slider1,'value',handles.img_hight);
        set(handles.slider2,'value',0);
   % ��ʹ��
        set(handles.PB_BaoCunTuXiang,'enable','on');
        set(handles.RB_BianHuanJiLian,'enable','on');
        set(handles.edit_XuanZhuan,'enable','on');
        set(handles.edit_X,'enable','on');
        set(handles.edit_Y,'enable','on');
        set(handles.edit_SuoFang,'enable','on');
        set(handles.pushbutton3,'enable','on');
        set(handles.pushbutton4,'enable','on');
        set(handles.pushbutton5,'enable','on');
        set(handles.pushbutton6,'enable','on');
        set(handles.pushbutton9,'enable','on');
        set(handles.pushbutton10,'enable','on');
   % ���½ṹ������
        guidata(hObject, handles)
        % ��ʾͼ��
        imshow(str);
   % �任����
        if get(handles.RB_BianHuanJiLian,'value')
            handles.img=res;
            % ���½ṹ������
            guidata(hObject, handles);
        end     
end


%% ����ͼ��
function PB_BaoCunTuXiang_Callback(hObject, eventdata, handles)
% ����ͼ��    
[FileName,PathName] =uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'����ͼ��',...
          'C:\Work\newfile.jpg');
if FileName==0
    return;
else
    h=getframe(handles.axes1);
    imwrite(h.cdata,[PathName,FileName]);
end


%% �ָ�ԭͼ
 function PB_HuiFuYuanTu_Callback(hObject, eventdata, handles)
% ͼ��ָ�
    handles.img=imread(handles.img_str);
% ״̬�ָ�
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
% ���½ṹ������
    guidata(hObject, handles);
    imshow(handles.img)


%% ��ת�任

%% 
% *������ת�Ƕ�* 
function edit_XuanZhuan_Callback(hObject, eventdata, handles)
%������ת��Ϊdouble����
Angle=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',Angle);

%%
% *ִ����ת����*
function PB_XuanZhuanBianHuan_Callback(hObject, eventdata, handles)
% ״̬�ָ�
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% ��ת�任
    res=repmat(255,handles.img_hight, handles.img_width);               % ������
    Angle = get(handles.edit_XuanZhuan,'value') * pi / 180.0;           % ��ת�Ƕ�
    tras = [ cos(Angle) -sin(Angle)  0;                                 % ��ת�ı任����
             sin(Angle) cos(Angle)   0; 
             0          0            1 ];       
    % ÿ��
    for i = 1 : handles.img_hight
        % ÿ��
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % ע�⣺temp��������
            % ����˷� temp=[ i*cos(Angle)-j*sin(Angle);
            %                 i*sin(Angle)+j*cos(Angle);
            %                           1               ]    
            temp = tras * temp;
            % ȡ��x��y���жϱ任���λ���Ƿ�Խ��
            x = uint16(temp(1, 1));
            y = uint16(temp(2, 1));
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(i, j) = handles.img(x, y);
            end
        end
    end;
% ��ʾͼ��
    imshow(uint8(res)); 
% �任�����豣�洦����ͼ��
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % ���½ṹ������
        guidata(hObject, handles);
    end  
%%
%
% <<��ת.bmp>>
% 


%% ƽ�Ʊ任

%%
% *����X����*
function edit_X_Callback(hObject, eventdata, handles)
% ��X����ֵתΪdouble����
X=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',X);
% ���µ�������
set(handles.slider2,'value',X);
guidata(hObject,handles);

%%
% *����Y����*
function edit_Y_Callback(hObject, eventdata, handles)
% ��Y����ֵתΪdouble����
Y=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',Y);
% ���µ�������
set(handles.slider1,'value',get(handles.slider1,'Max')-Y);
guidata(hObject,handles);

%%
% *X��ƽ�Ʊ任������*
function slider_X_Callback(hObject, eventdata, handles)
% ����X�Ử�������ֵ
set(hObject,'Max',handles.img_hight);
% ���±༭���е�����
X_str=num2str(get(hObject,'value'));
X_value=uint16(get(hObject,'value'));
set(handles.edit_X,'String',X_str,'value',X_value);
% ���½ṹ������
guidata(hObject, handles);

%%
% *Y��ƽ�Ʊ任������*
function slider_Y_Callback(hObject, eventdata, handles)
% ����Y�Ử�������ֵ
set(hObject,'Max',handles.img_hight);
% ���±༭���е�����
Y_str=num2str(handles.img_hight-get(hObject,'value'));
Y_value=handles.img_hight-uint16(get(hObject,'value'));
set(handles.edit_Y,'String',Y_str,'value',Y_value);
% ���½ṹ������
guidata(hObject, handles);

%% 
% *ƽ�Ʊ任*
function PB_PingYiBianHuan_Callback(hObject, eventdata, handles)
% ״̬�ָ�
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_SuoFang,'String','0');
end
% ƽ�Ʊ任
    res=repmat(255,handles.img_hight, handles.img_width);% ������
    X = get(handles.edit_Y,'value'); % ����ƽ����X
    Y = get(handles.edit_X,'value'); % ����ƽ����Y
    tras = [1 0 X; 
            0 1 Y; 
            0 0 1 ];     % ƽ�Ƶı任����
    % ÿ��
    for i = 1 : handles.img_hight
        % ÿ��
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % ע�⣺temp��������
            % ����˷� temp=[i+X;
            %                j+Y;
            %                1   ] 
            temp = tras * temp; 
            % ȡ��x��y���жϱ任���λ���Ƿ�Խ��
            x = temp(1, 1);
            y = temp(2, 1);
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(x, y) = handles.img(i,j);
            end
        end
    end;
% ��ʾͼ��
    imshow(uint8(res)); 
% �任�����豣�洦����ͼ��
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % ���½ṹ������
        guidata(hObject, handles);
    end
%%
%
% <<ƽ��.bmp>>
% 
 

%% ���ű任
%%
% *�������ű���*
function edit_SuoFang_Callback(hObject, eventdata, handles)
% �����ű���תΪdouble����
SuoFang=str2double(get(hObject,'String'));
% ���浽�ؼ�������
set(hObject,'value',SuoFang);

%%
% *���ű任*
function PB_SuoFangBianHuan_Callback(hObject, eventdata, handles)
% ״̬�ָ�
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% ���ű任
    res=repmat(255,handles.img_hight, handles.img_width);               % ������
    Multiple = get(handles.edit_SuoFang,'value');                       % �����ı���
    tras = [ 1/Multiple 0 0; 
             0 1/Multiple 0; 
             0      0     1 ];       % �����ı任����
    % ÿ��
    for i = 1 : handles.img_hight
        % ÿ��
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % ע�⣺temp��������
            % ����˷� temp=[ 1/Multiple * i;
            %                 1/Multiple * j;
            %                       1        ]    
            temp = tras * temp;
            % ȡ��x��y���жϱ任���λ���Ƿ�Խ��
            x = uint16(temp(1, 1));
            y = uint16(temp(2, 1));
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(i, j) = handles.img(x, y);
            end
        end
    end;
% ��ʾͼ��
    imshow(uint8(res)); 
% �任�����豣�洦����ͼ��
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % ���½ṹ������
        guidata(hObject, handles);
    end

%%
% 
% <<����.bmp>>
% 


%% ����任

%%
% *ˮƽ����*
function PB_ShuiPingJingXiang_Callback(hObject, eventdata, handles)
% ״̬�ָ�
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% ˮƽ����
    res=repmat(255,handles.img_hight, handles.img_width);               % ������
    % ÿ��
    for i = 1 : handles.img_hight
        % ÿ��
        for j = 1 : handles.img_width
            x=i;                    % �����겻��
            y=handles.img_width-j+1;% �����꾵��
            res(x,y)=handles.img(i,j);
        end
    end
% ��ʾͼ��
    imshow(uint8(res)); 
% �任�����豣�洦����ͼ��
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % ���½ṹ������
        guidata(hObject, handles);
    end  
% ��ӿ���
    snapnow;

%%
% 
% <<ˮƽ.bmp>>
% 

%%
% *��ֱ����*
function PB_ChuiZhiJingXiang_Callback(hObject, eventdata, handles)
% ״̬�ָ�
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% ��ֱ����
    res=repmat(255,handles.img_hight, handles.img_width);               % ������
    % ÿ��
    for i = 1 : handles.img_width
        % ÿ��
        for j = 1 : handles.img_hight
            y=handles.img_hight-j+1;% �����꾵��
            x=i;                    % �����겻��
            res(y,x)=handles.img(j,i);
        end
    end
% ��ʾͼ��
    imshow(uint8(res));
% �任�����豣�洦����ͼ��
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % ���½ṹ������
        guidata(hObject, handles);
    end 
    
%%
% 
% <<��ֱ.bmp>>
% 


%% �任����
function RB_BianHuanJiLian_Callback(hObject, eventdata, handles)
% ʹ��
    RB_ChuLiGuanLian.value=true;
% ״̬�ָ�
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
% ���½ṹ������
    guidata(hObject, handles)
    imshow(handles.img);

%%
% 
% <<����.bmp>>
% 
    
