%% 点操作---坐标变换
% * 概述      ：
% *实现图像的坐标变换，主要有旋转，平移，放缩，镜像，级联五种变换，对应反变*
% *换实现方法类似，本例未添加*
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[4/5/2017]  


%%
%
% <<main.bmp>>
%


%% 主函数
% *不做任何修改*
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


%% 开始函数
% *相关初始化*
function DCZZuoBiaoBianHuan_OpeningFcn(hObject, eventdata, handles, varargin)
% 全局变量
    handles.img_str=0;      % 图像地址
    handles.img=0;          % 图像数据
    handles.img_width=0;    % 图像宽
    handles.img_hight=0;    % 图像高
% 打开并显示原图像
    axes(handles.axes1);
    str=' ';
    % 图像由参数传入
    if nargin ==2
        if ischar(varargin{2})
        % 显示图像
        str=varargin{2};
        end
    % 重新打开图像
    else
        % 提示
            load chirp   % 鸟声
            sound(y,Fs);
            hs=msgbox('图片未加载！','通知','warn');
            ht=findobj(hs,'type','text');
            set(ht,'FontSize',11);
            % 等待确定
            uiwait(hs);
    end
    % 显示原图像
    if str~=' '
        imshow(str);
        % 数据初始化
        handles.img_str=str;        % 图像地址
        handles.img=imread(str);    % 图像数据
        [hight,width]=size(handles.img);
        handles.img_width=width;    % 图像宽
        handles.img_hight=hight;    % 图像高
        set(handles.slider1,'Max',1000);
        set(handles.slider1,'value',1000);
    else % 未传入图像，关闭使能
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


%% 输出函数
function DCZZuoBiaoBianHuan_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% 加载图像
function PB_JiaZaiTuXiang_Callback(hObject, eventdata, handles)
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'选择图片');
if index              
   % 数据初始化
        str=[pname fname]; 
        handles.img_str=str;        % 图像地址
        handles.img=imread(str);    % 图像数据
        [hight,width]=size(handles.img);
        handles.img_width=width;    % 图像宽
        handles.img_hight=hight;    % 图像高
        set(handles.slider1,'Max',hight);
        set(handles.slider1,'value',hight);        
   % 状态恢复
        set(handles.edit_XuanZhuan,'String','0');
        set(handles.edit_X,'String','0');
        set(handles.edit_Y,'String','0');
        set(handles.edit_SuoFang,'String','0');
        set(handles.slider1,'value',handles.img_hight);
        set(handles.slider2,'value',0);
   % 打开使能
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
   % 更新结构体数据
        guidata(hObject, handles)
        % 显示图像
        imshow(str);
   % 变换级联
        if get(handles.RB_BianHuanJiLian,'value')
            handles.img=res;
            % 更新结构体数据
            guidata(hObject, handles);
        end     
end


%% 保存图像
function PB_BaoCunTuXiang_Callback(hObject, eventdata, handles)
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


%% 恢复原图
 function PB_HuiFuYuanTu_Callback(hObject, eventdata, handles)
% 图像恢复
    handles.img=imread(handles.img_str);
% 状态恢复
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
% 更新结构体数据
    guidata(hObject, handles);
    imshow(handles.img)


%% 旋转变换

%% 
% *输入旋转角度* 
function edit_XuanZhuan_Callback(hObject, eventdata, handles)
%将数据转化为double类型
Angle=str2double(get(hObject,'String'));
% 保存到控件数据中
set(hObject,'value',Angle);

%%
% *执行旋转操作*
function PB_XuanZhuanBianHuan_Callback(hObject, eventdata, handles)
% 状态恢复
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% 旋转变换
    res=repmat(255,handles.img_hight, handles.img_width);               % 保存结果
    Angle = get(handles.edit_XuanZhuan,'value') * pi / 180.0;           % 旋转角度
    tras = [ cos(Angle) -sin(Angle)  0;                                 % 旋转的变换矩阵
             sin(Angle) cos(Angle)   0; 
             0          0            1 ];       
    % 每行
    for i = 1 : handles.img_hight
        % 每列
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % 注意：temp是列向量
            % 矩阵乘法 temp=[ i*cos(Angle)-j*sin(Angle);
            %                 i*sin(Angle)+j*cos(Angle);
            %                           1               ]    
            temp = tras * temp;
            % 取出x，y并判断变换后的位置是否越界
            x = uint16(temp(1, 1));
            y = uint16(temp(2, 1));
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(i, j) = handles.img(x, y);
            end
        end
    end;
% 显示图像
    imshow(uint8(res)); 
% 变换级联需保存处理后的图像
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % 更新结构体数据
        guidata(hObject, handles);
    end  
%%
%
% <<旋转.bmp>>
% 


%% 平移变换

%%
% *输入X坐标*
function edit_X_Callback(hObject, eventdata, handles)
% 将X坐标值转为double类型
X=str2double(get(hObject,'String'));
% 保存到控件数据中
set(hObject,'value',X);
% 更新到滑动条
set(handles.slider2,'value',X);
guidata(hObject,handles);

%%
% *输入Y坐标*
function edit_Y_Callback(hObject, eventdata, handles)
% 将Y坐标值转为double类型
Y=str2double(get(hObject,'String'));
% 保存到控件数据中
set(hObject,'value',Y);
% 更新到滑动条
set(handles.slider1,'value',get(handles.slider1,'Max')-Y);
guidata(hObject,handles);

%%
% *X轴平移变换滑动条*
function slider_X_Callback(hObject, eventdata, handles)
% 设置X轴滑动条最大值
set(hObject,'Max',handles.img_hight);
% 更新编辑框中的数据
X_str=num2str(get(hObject,'value'));
X_value=uint16(get(hObject,'value'));
set(handles.edit_X,'String',X_str,'value',X_value);
% 更新结构体数据
guidata(hObject, handles);

%%
% *Y轴平移变换滑动条*
function slider_Y_Callback(hObject, eventdata, handles)
% 设置Y轴滑动条最大值
set(hObject,'Max',handles.img_hight);
% 更新编辑框中的数据
Y_str=num2str(handles.img_hight-get(hObject,'value'));
Y_value=handles.img_hight-uint16(get(hObject,'value'));
set(handles.edit_Y,'String',Y_str,'value',Y_value);
% 更新结构体数据
guidata(hObject, handles);

%% 
% *平移变换*
function PB_PingYiBianHuan_Callback(hObject, eventdata, handles)
% 状态恢复
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_SuoFang,'String','0');
end
% 平移变换
    res=repmat(255,handles.img_hight, handles.img_width);% 保存结果
    X = get(handles.edit_Y,'value'); % 检索平移量X
    Y = get(handles.edit_X,'value'); % 检索平移量Y
    tras = [1 0 X; 
            0 1 Y; 
            0 0 1 ];     % 平移的变换矩阵
    % 每行
    for i = 1 : handles.img_hight
        % 每列
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % 注意：temp是列向量
            % 矩阵乘法 temp=[i+X;
            %                j+Y;
            %                1   ] 
            temp = tras * temp; 
            % 取出x，y并判断变换后的位置是否越界
            x = temp(1, 1);
            y = temp(2, 1);
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(x, y) = handles.img(i,j);
            end
        end
    end;
% 显示图像
    imshow(uint8(res)); 
% 变换级联需保存处理后的图像
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % 更新结构体数据
        guidata(hObject, handles);
    end
%%
%
% <<平移.bmp>>
% 
 

%% 缩放变换
%%
% *输入缩放倍数*
function edit_SuoFang_Callback(hObject, eventdata, handles)
% 将缩放倍数转为double类型
SuoFang=str2double(get(hObject,'String'));
% 保存到控件数据中
set(hObject,'value',SuoFang);

%%
% *缩放变换*
function PB_SuoFangBianHuan_Callback(hObject, eventdata, handles)
% 状态恢复
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% 缩放变换
    res=repmat(255,handles.img_hight, handles.img_width);               % 保存结果
    Multiple = get(handles.edit_SuoFang,'value');                       % 放缩的倍数
    tras = [ 1/Multiple 0 0; 
             0 1/Multiple 0; 
             0      0     1 ];       % 放缩的变换矩阵
    % 每行
    for i = 1 : handles.img_hight
        % 每列
        for j = 1 : handles.img_width
            temp = [i; j; 1];
            % 注意：temp是列向量
            % 矩阵乘法 temp=[ 1/Multiple * i;
            %                 1/Multiple * j;
            %                       1        ]    
            temp = tras * temp;
            % 取出x，y并判断变换后的位置是否越界
            x = uint16(temp(1, 1));
            y = uint16(temp(2, 1));
            if (x <= handles.img_hight) && (y <= handles.img_width) && (x >= 1) && (y >= 1)
                res(i, j) = handles.img(x, y);
            end
        end
    end;
% 显示图像
    imshow(uint8(res)); 
% 变换级联需保存处理后的图像
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % 更新结构体数据
        guidata(hObject, handles);
    end

%%
% 
% <<缩放.bmp>>
% 


%% 镜像变换

%%
% *水平镜像*
function PB_ShuiPingJingXiang_Callback(hObject, eventdata, handles)
% 状态恢复
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% 水平镜像
    res=repmat(255,handles.img_hight, handles.img_width);               % 保存结果
    % 每行
    for i = 1 : handles.img_hight
        % 每列
        for j = 1 : handles.img_width
            x=i;                    % 行坐标不变
            y=handles.img_width-j+1;% 列坐标镜像
            res(x,y)=handles.img(i,j);
        end
    end
% 显示图像
    imshow(uint8(res)); 
% 变换级联需保存处理后的图像
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % 更新结构体数据
        guidata(hObject, handles);
    end  
% 添加快照
    snapnow;

%%
% 
% <<水平.bmp>>
% 

%%
% *垂直镜像*
function PB_ChuiZhiJingXiang_Callback(hObject, eventdata, handles)
% 状态恢复
if true ~= get(handles.RB_BianHuanJiLian,'value')
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
end
% 垂直镜像
    res=repmat(255,handles.img_hight, handles.img_width);               % 保存结果
    % 每列
    for i = 1 : handles.img_width
        % 每行
        for j = 1 : handles.img_hight
            y=handles.img_hight-j+1;% 行坐标镜像
            x=i;                    % 列坐标不变
            res(y,x)=handles.img(j,i);
        end
    end
% 显示图像
    imshow(uint8(res));
% 变换级联需保存处理后的图像
    if get(handles.RB_BianHuanJiLian,'value')
        handles.img=res;
        % 更新结构体数据
        guidata(hObject, handles);
    end 
    
%%
% 
% <<垂直.bmp>>
% 


%% 变换级联
function RB_BianHuanJiLian_Callback(hObject, eventdata, handles)
% 使能
    RB_ChuLiGuanLian.value=true;
% 状态恢复
    set(handles.edit_XuanZhuan,'String','0');
    set(handles.edit_X,'String','0');
    set(handles.edit_Y,'String','0');
    set(handles.edit_SuoFang,'String','0');
    set(handles.slider1,'value',handles.img_hight);
    set(handles.slider2,'value',0);
% 更新结构体数据
    guidata(hObject, handles)
    imshow(handles.img);

%%
% 
% <<级联.bmp>>
% 
    
