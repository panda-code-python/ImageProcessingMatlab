%% 模板操作---模板运算
% * 概述      ：主要实现对图像的模板运算
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[9/5/2017]  
%%

%%
%
% <<main.bmp>>
%


%% 主函数
% *不做任何修改*
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


%% 开始函数
% *相关初始化*
function MBCZMoBanYunSuan_OpeningFcn(hObject, eventdata, handles, varargin)
% 全局变量
    handles.img_str=' ';        % 图像地址
    handles.img=0;              % 图像数据
    handles.img_width=0;        % 图像宽
    handles.img_height=0;       % 图像高    
% 设置模板初值
    temp=ones(11);
    set(handles.uitable1,'data',temp,'ColumnWidth',{20});
   % 打开使能
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


%% 输出函数
function MBCZMoBanYunSuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;


%% 输入模板大小
function edit1_Callback(hObject, eventdata, handles)
% 模板大小
    N=str2double(get(hObject,'String'));
    M=zeros(N);
    % 更新到uitable1
    if N>11                                 % 模板最大为11x11
        load chirp                          % 鸟声
        sound(y,Fs);
        hs=msgbox('模板过大！','警告','warn');
        ht=findobj(hs,'type','text');
        set(ht,'FontSize',11);
        uiwait(hs);                         % 等待确定
        return ;
    else
        set(handles.uitable1,'Data',M);
        guidata(hObject,handles);
    end

    
%%  使用模板
function usePlate_Callback(hObject, eventdata, handles)
% 使用模板
% 检索模板大小 
    N=str2double(get(handles.edit1,'String'));
% 检索模板数据
    plate=get(handles.uitable1,'data');
% 检索图像数据
    dX=double(handles.img);
% 使用模板漫游图像
    for i=1:handles.img_width-N+1
       for j=1:handles.img_height-N+1
            temp=dX(i:i+(N-1),j:j+(N-1));   % 取出图像中与模版对应的数据
            wf=sum(sum(plate.*temp));       % 卷积运算
            M=sum(sum(plate));              % 求模板的系数和
            g=wf/M;                         % 计算模板中心点灰度值 
            dX(i:i+(N-1)/2,j:j+(N-1)/2)=g;  % 将灰度值写入图像对应的位置               
       end
    end  
% 更新并显示图像
    handles.img=uint8(dX);
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(handles.img); 
        
        
%% 清除模板
function clearPlate_Callback(hObject, eventdata, handles)
% 清除模板
% 设置模板为初值
    temp=ones(11);
    set(handles.edit1,'String','11');
    set(handles.uitable1,'data',temp,'ColumnWidth',{20});
    guidata(hObject,handles);
    
    
%% 加载图像
function load_Callback(hObject, eventdata, handles)
% 加载图像
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'选择图片');
if index              
   % 数据初始化
        str=[pname fname]; 
        handles.img_str=str;        % 图像地址
        handles.img=imread(str);    % 图像数据
        handles.img_old=handles.img;% 源图像
        [hight,width]=size(handles.img);
        handles.img_width=width;    % 图像宽
        handles.img_height=hight;   % 图像高      
   % 打开使能
        set(handles.recover,'enable','on');
        set(handles.usePlate,'enable','on');
        set(handles.clearPlate,'enable','on');
        set(handles.edit1,'enable','on');
   % 更新结构体数据
        guidata(hObject, handles)
        % 显示图像
        axes(handles.axes1);
        imshow(str); 
end


%% 恢复图像
function recover_Callback(hObject, eventdata, handles)
% 恢复图像
% 恢复原图
    handles.img=handles.img_old;
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(uint8(handles.img));

%% 结果展示

%%
%
% <<test1.bmp>>
%    

%%
%
% <<test2.bmp>>
%  