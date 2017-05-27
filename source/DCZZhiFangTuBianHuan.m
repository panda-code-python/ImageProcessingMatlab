%% �����-ֱ��ͼ�任
% * ����      ����Ҫʵ��ͼ���ֱ��ͼ���⻯
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[9/5/2017]  
%%


%%
%
% <<main.bmp>>
%


%% ������
% *�����κ��޸�*
function varargout = DCZZhiFangTuBianHuan(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCZZhiFangTuBianHuan_OpeningFcn, ...
                   'gui_OutputFcn',  @DCZZhiFangTuBianHuan_OutputFcn, ...
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
function DCZZhiFangTuBianHuan_OpeningFcn(hObject, eventdata, handles, varargin)
% ȫ�ֱ���
    handles.img_str=' ';        % ͼ���ַ
    handles.img=0;              % ͼ������
    handles.img_old=0;          % Դͼ��
    handles.img_width=0;        % ͼ���
    handles.img_height=0;        % ͼ���    
% ����
    set(handles.junHengHua,'enable','off');
    set(handles.recover,'enable','off');
    set(handles.save,'enable','off');
    
% Choose default command line output for DCZZhiFangTuBianHuan
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes DCZZhiFangTuBianHuan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% �������
function DCZZhiFangTuBianHuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% �ָ�ͼ��
function recover_Callback(hObject, eventdata, handles)
% �ָ�ͼ��
    handles.img=handles.img_old;
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(uint8(handles.img));
    
    
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
        handles.img_height=hight;    % ͼ���      
   % ��ʹ��
        set(handles.junHengHua,'enable','on');
        set(handles.recover,'enable','on');
        set(handles.save,'enable','on');
   % ���½ṹ������
        guidata(hObject, handles);
        % ��ʾͼ��
        axes(handles.axes1);
        imshow(str); 
end


%% ����ͼ��
function save_Callback(hObject, eventdata, handles)
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


%% ֱ��ͼ���⻯
function junHengHua_Callback(hObject, eventdata, handles)
% ֱ��ͼ���⻯
src_img=handles.img;
% ��ȡͼ���ά��
    [height,width] = size(src_img);
    I=size(src_img);
% ԭʼͼ��Ҷȼ� k=256,
% ����ͼƬ�и����Ҷȼ������صĸ���
    pixelNum=zeros(1,256);
% ͳ��ͼƬ��ÿ���Ҷȼ����صĸ���
% ���ã� ͼƬ��ÿ�����ص�ĻҶ�ֵΪ (0,255)֮�������,
%        ���������ص����������Ϊһά���飬��Ϊ(1,256)
%        ���Կ���ͨ���Ҷ�ֵ��һ�õ�����������ţ��ٽ���Ӧ
%        λ�õļ�����һ���Ӷ�����ͳ�Ƴ�ÿ���Ҷȼ����صĸ�����
    for i=1:height
        for j=1:width
            pixelNum(src_img(i,j)+1)=pixelNum(src_img(i,j)+1) +1;
        end
    end
% ��һ�� ����������Ҷȼ��ĸ���
% ԭʼֱ��ͼ ��Original histogram��
    Sk=zeros(1,256);
    for i=1:256
        Sk(i)=pixelNum(i)/(height*width*1.0);
    end
    axes(handles.axes2),bar(Sk),title('�ۼ�ֱ��ͼ');
% �ۼ�ֱ��ͼ ��Cumulative histogram�� 
    Tk=zeros(1,256);% �����ۻ���ĸ���
    for i = 1:256
        if i==1
            Tk(i)=Sk(i);
        else
            Tk(i)=Tk(i-1)+Sk(i);
        end
    end
    axes(handles.axes3),bar(Tk),title('�ۼ�ֱ��ͼ');
% ȡ����չ��Integral expansion�� 
% ��ʽ�� pixelCumu = int[(L-1)*pixelCumu+0.5]��LΪ�Ҷȼ���
    Tk(i) = uint8((256-1) .* Tk(i) + 0.5);
% �ԻҶ�ֵ����ӳ��
    for i=1:height
        for j=1:width
            I(i,j)=Tk(src_img(i,j));
        end
    end
    axes(handles.axes4),imshow(I);
    
%%
%
% <<ֱ��ͼ���⻯.bmp>>
%