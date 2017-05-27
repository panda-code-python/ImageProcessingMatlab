%% 点操作-直方图变换
% * 概述      ：主要实现图像的直方图均衡化
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[9/5/2017]  
%%


%%
%
% <<main.bmp>>
%


%% 主函数
% *不做任何修改*
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


%% 开始函数
% *相关初始化*
function DCZZhiFangTuBianHuan_OpeningFcn(hObject, eventdata, handles, varargin)
% 全局变量
    handles.img_str=' ';        % 图像地址
    handles.img=0;              % 图像数据
    handles.img_old=0;          % 源图像
    handles.img_width=0;        % 图像宽
    handles.img_height=0;        % 图像高    
% 设置
    set(handles.junHengHua,'enable','off');
    set(handles.recover,'enable','off');
    set(handles.save,'enable','off');
    
% Choose default command line output for DCZZhiFangTuBianHuan
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes DCZZhiFangTuBianHuan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% 输出函数
function DCZZhiFangTuBianHuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% 恢复图像
function recover_Callback(hObject, eventdata, handles)
% 恢复图像
    handles.img=handles.img_old;
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(uint8(handles.img));
    
    
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
        handles.img_height=hight;    % 图像高      
   % 打开使能
        set(handles.junHengHua,'enable','on');
        set(handles.recover,'enable','on');
        set(handles.save,'enable','on');
   % 更新结构体数据
        guidata(hObject, handles);
        % 显示图像
        axes(handles.axes1);
        imshow(str); 
end


%% 保存图像
function save_Callback(hObject, eventdata, handles)
% 保存图像
    [FileName,PathName] =uiputfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
              '*.*','All Files' },'保存图像',...
              'C:\Work\newfile.jpg');
    if FileName==0
        return;
    else
        h=getframe(handles.axes1);
        imwrite(h.cdata,[PathName,FileName]);
    end


%% 直方图均衡化
function junHengHua_Callback(hObject, eventdata, handles)
% 直方图均衡化
src_img=handles.img;
% 获取图像的维数
    [height,width] = size(src_img);
    I=size(src_img);
% 原始图像灰度级 k=256,
% 保存图片中各个灰度级的像素的个数
    pixelNum=zeros(1,256);
% 统计图片中每个灰度级像素的个数
% 妙用： 图片中每个像素点的灰度值为 (0,255)之间的整数,
%        而保存像素点个数的数组为一维数组，且为(1,256)
%        所以可以通过灰度值加一得到数组的索引号，再将对应
%        位置的计数加一，从而可以统计出每个灰度级像素的个数。
    for i=1:height
        for j=1:width
            pixelNum(src_img(i,j)+1)=pixelNum(src_img(i,j)+1) +1;
        end
    end
% 归一化 即计算各个灰度级的概率
% 原始直方图 （Original histogram）
    Sk=zeros(1,256);
    for i=1:256
        Sk(i)=pixelNum(i)/(height*width*1.0);
    end
    axes(handles.axes2),bar(Sk),title('累计直方图');
% 累计直方图 （Cumulative histogram） 
    Tk=zeros(1,256);% 保存累积后的概率
    for i = 1:256
        if i==1
            Tk(i)=Sk(i);
        else
            Tk(i)=Tk(i-1)+Sk(i);
        end
    end
    axes(handles.axes3),bar(Tk),title('累计直方图');
% 取整扩展（Integral expansion） 
% 公式： pixelCumu = int[(L-1)*pixelCumu+0.5]（L为灰度级）
    Tk(i) = uint8((256-1) .* Tk(i) + 0.5);
% 对灰度值进行映射
    for i=1:height
        for j=1:width
            I(i,j)=Tk(src_img(i,j));
        end
    end
    axes(handles.axes4),imshow(I);
    
%%
%
% <<直方图均衡化.bmp>>
%