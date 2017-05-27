%% 点操作---图像间运算
% * 概述      ：实现图像间的算术和逻辑运算
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[4/5/2017]
%%

%%
%
% <<main.bmp>>
%

%% 主函数
% *不做任何修改*
function varargout = DCZTuXiangJianYunSuan(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCZTuXiangJianYunSuan_OpeningFcn, ...
                   'gui_OutputFcn',  @DCZTuXiangJianYunSuan_OutputFcn, ...
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
function DCZTuXiangJianYunSuan_OpeningFcn(hObject, eventdata, handles, varargin)
% 全局变量
    % N阶方阵
    handles.N=0;
    % A图像
    handles.imgA_old=0;      % A图像地址
    handles.imgA=0;          % A图像数据
    % B图像
    handles.imgB_old=0;      % B图像地址
    handles.imgB=0;          % B图像数据
    % C图像
    handles.imgC_old=0;      % C图像地址
    handles.imgC=0;          % C图像数据          
    % p,  q,  op操作
    handles.p=0;
    handles.q=0;
    handles.op=0;
% 控件初始化
    % A=1\2\3\PB_UpData_A\PB_Recover_A 
    set(handles.A_p,'enable','off','string',{'A';'B';'C';'_'});
    set(handles.A_algorithm,'enable','off','string',{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'});
    set(handles.A_q,'enable','off','string',{'A';'B';'C'});
    set(handles.PB_UpData_A,'enable','off');
    set(handles.PB_Recover_A,'enable','off');
    % B=4\5\6\PB_UpData_B\PB_Recover_B
    set(handles.B_p,'enable','off','string',{'A';'B';'C';'_'});
    set(handles.B_algorithm,'enable','off','string',{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'});
    set(handles.B_q,'enable','off','string',{'A';'B';'C'});
    set(handles.PB_UpData_B,'enable','off');
    set(handles.PB_Recover_B,'enable','off');
    % C=7\8\9\PB_UpData_C\PB_Recover_C
    set(handles.C_p,'enable','on','string',{'A';'B';'C';'_'});
    set(handles.C_algorithm,'enable','off','string',{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'});
    set(handles.C_q,'enable','off','string',{'A';'B';'C'});
    set(handles.PB_UpData_C,'enable','off');
    set(handles.PB_Recover_C,'enable','off');
% Choose default command line output for DCZTuXiangJianYunSuan
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes DCZTuXiangJianYunSuan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% 输出函数
function DCZTuXiangJianYunSuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% 恢复A图像
function PB_Recover_A_Callback(hObject, eventdata, handles)
% 恢复A图像
    handles.imgA=handles.imgA_old;
% 更新结构体数据
    guidata(hObject, handles);
% 设置图像显示区域
    axes(handles.axes1);
    imshow(uint8(handles.imgA));
   

%% 加载A图像    
function PB_Load_A_Callback(hObject, eventdata, handles)
% 加载A图像  
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'选择图片');
if index 
    str=[pname fname];    
end
if str~=' '
   % 数据初始化
        handles.imgA=uint8(imread(str));    % 图像数据
   % 图像尺寸处理
        % 检索图像的尺寸
        [Ahight,Awidth]=size(handles.imgA);
        % 检索尺寸最大值
        handles.N=max([Ahight,Awidth,handles.N]);
        % 构造三个全为1的N阶方阵
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % 将A,B,C图像分别放到N阶方阵中
        tempA(1:Ahight,1:Awidth)=handles.imgA;
        [Bhight,Bwidth]=size(handles.imgB);
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        [Chight,Cwidth]=size(handles.imgC);
        tempC(1:Chight,1:Cwidth)=handles.imgC;
        % 再分别赋值给全局变量
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC();
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % 更新结构体数据
        guidata(hObject, handles);
   % 控件初始化
        % 更新图像
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % 打开相关使能
        set(handles.A_p,'enable','on');
end
 

%% 更新A图像   
function PB_UpData_A_Callback(hObject, eventdata, handles)
% 更新A图像 
% 执行图像运算
    %   1   2   3   4   5     6    7     8    9
    % {'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'}
    switch get(handles.A_algorithm,'value')
        case 1
            handles.imgA=handles.p+handles.q;
        case 2
            handles.imgA=handles.p-handles.q;
        case 3
            handles.imgA=handles.p .* handles.q;
        case 4
            handles.imgA=handles.p ./ handles.q;
        case 5
            handles.imgA=handles.p .* handles.q;
        case 6
            handles.imgA=handles.p+handles.q;
        case 7
            temp=handles.p+handles.q;
            temp(temp>500)=0;
            handles.imgA=temp;
        case 8
            if get(handles.A_p,'value')==4
                handles.imgA=255-handles.q;
            else
                hs=msgbox('语法错误!','错误','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end
        case 9
            if get(handles.A_p,'value') == 4
                handles.imgA= handles.q;     
            else
                h=msgbox('语法错误!','错误','error');uiwait(h);
                ht=findobj(h,'type','text');
                set(ht,'FontSize',16);                       
            end
    end
% 更新结构体数据
    guidata(hObject, handles);
    % 设置图像显示区域
    axes(handles.axes1);        
    % 显示图像
    imshow(uint8(handles.imgA));
% 设置相关使能
    set(hObject,'enable','off');
    set(handles.A_p,'enable','on');
    set(handles.A_algorithm,'enable','off');
    set(handles.A_q,'enable','off');
    set(handles.PB_Recover_A,'enable','on');


%% A_p 赋值    
function A_p_Callback(hObject, eventdata, handles)
% A_p 赋值
    %   1   2   3   4
    % {'A';'B';'C';'_'}
    switch get(hObject,'value')
    case 1
        handles.p=handles.imgA;
    case 2
        handles.p=handles.imgB;
    case 3
        handles.p=handles.imgC;
    case 4
        handles.p=repmat(255,handles.N,handles.N);
    end
% 打开相关使能
    set(handles.A_algorithm,'enable','on');
% 更新结构体数据
    guidata(hObject, handles);

    
%% A_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值
function A_algorithm_Callback(hObject, eventdata, handles)
% A_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值
% 打开相关使能
    set(handles.A_q,'enable','on');    


%% A_q 赋值    
function A_q_Callback(hObject, eventdata, handles)
% A_q 赋值
    %   1   2   3 
    % {'A';'B';'C'}
    switch get(hObject,'value')
        case 1
            handles.q=handles.imgA;
        case 2
            handles.q=handles.imgB;
        case 3
            handles.q=handles.imgC;
    end
% 打开相关使能
    set(handles.PB_UpData_A,'Enable','on');
% 更新结构体数据
    guidata(hObject, handles);


%% 恢复B图像
function PB_Recover_B_Callback(hObject, eventdata, handles)
% 恢复B图像
    handles.imgB=handles.imgB_old;
% 更新结构体数据
    guidata(hObject, handles);
% 设置图像显示区域
    axes(handles.axes2);
    imshow(uint8(handles.imgB));
    

%% 加载B图像    
function PB_Load_B_Callback(hObject, eventdata, handles)
% 加载B图像 
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'选择图片');
if index 
    str=[pname fname];    
end
if str~=' '
   % 数据初始化
        handles.imgB=uint8(imread(str));    % 图像数据
   % 图像尺寸处理
        % 检索图像的尺寸
        [Bhight,Bwidth]=size(handles.imgB);      
        % 检索尺寸最大值
        handles.N=max([Bhight,Bwidth,handles.N]);
        % 构造三个全为1的N阶方阵
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % 将A,B,C图像分别放到N阶方阵中
        [Ahight,Awidth]=size(handles.imgA);
        tempA(1:Ahight,1:Awidth)=handles.imgA;            
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        [Chight,Cwidth]=size(handles.imgC);
        tempC(1:Chight,1:Cwidth)=handles.imgC;
        % 再分别赋值给全局变量
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC();
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % 更新结构体数据
        guidata(hObject, handles);
   % 控件初始化
        % 更新图像
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % 打开相关使能
        set(handles.B_p,'enable','on');
end
   

%% 更新B图像
function PB_UpData_B_Callback(hObject, eventdata, handles)
% 更新B图像
% 执行图像运算
    %   1   2   3   4   5     6    7     8    9
    % {'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'}
    switch get(handles.B_algorithm,'value')
        case 1
            handles.imgB=handles.p+handles.q;
        case 2
            handles.imgB=handles.p-handles.q;
        case 3
            handles.imgB=handles.p .* handles.q;
        case 4
            handles.imgB=handles.p ./ handles.q;
        case 5
            handles.imgB=handles.p.*handles.q;
        case 6
            handles.imgB=handles.p+handles.q;
        case 7
            temp=handles.p+handles.q;
            temp(temp>500)=0;
            handles.imgB=temp;
        case 8
            if get(handles.B_p,'value')==4
                handles.imgB=255-handles.q;
            else
                hs=msgbox('语法错误!','错误','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end
        case 9
            if get(handles.B_p,'value') == 4
                handles.imgB= handles.q;     
            else
                h=msgbox('语法错误!','错误','error');
                ht=findobj(h,'type','text');
                set(ht,'FontSize',16);  
                uiwait(h);
            end
    end
% 更新结构体数据
    guidata(hObject, handles);
    % 设置图像显示区域
    axes(handles.axes2);         
    % 显示图像
    imshow(uint8(handles.imgB));
% 设置相关使能
    set(hObject,'enable','off');
    set(handles.B_p,'enable','on');
    set(handles.B_algorithm,'enable','off');
    set(handles.B_q,'enable','off');
    set(handles.PB_Recover_B,'enable','on');


%% B_p 赋值    
function B_p_Callback(hObject, eventdata, handles)
% B_p 赋值 
    %   1   2   3   4
    % {'A';'B';'C';'_'}
    switch get(hObject,'value')
        case 1
            handles.p=handles.imgA;
        case 2
            handles.p=handles.imgB;
        case 3
            handles.p=handles.imgC;
        case 4
            handles.p=repmat(255,handles.N,handles.N);
    end
% 打开相关使能
    set(handles.B_algorithm,'enable','on');
% 更新结构体数据
    guidata(hObject, handles);
 

%% B_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值    
function B_algorithm_Callback(hObject, eventdata, handles)
% B_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值
% 打开相关使能
    set(handles.B_q,'enable','on');


%% B_q 赋值    
function B_q_Callback(hObject, eventdata, handles)
% B_q 赋值
    %   1   2   3 
    % {'A';'B';'C'}  
    switch get(hObject,'value')
        case 1
            handles.q=handles.imgA;
        case 2
            handles.q=handles.imgB;
        case 3
            handles.q=handles.imgC;
    end
% 打开相关使能
    set(handles.PB_UpData_B,'Enable','on');
% 更新结构体数据
    guidata(hObject, handles);


%% 恢复C图像
function PB_Recover_C_Callback(hObject, eventdata, handles)
% 恢复C图像 
    handles.imgC=handles.imgC_old;
% 更新结构体数据
    guidata(hObject, handles);
% 设置图像显示区域
    axes(handles.axes3);
% 显示图像
    imshow(uint8(handles.imgC));
 

%% 加载C图像    
function PB_Load_C_Callback(hObject, eventdata, handles)
% 加载C图像
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'选择图片');
if index 
    str=[pname fname];    
end
if str~=' '
   % 数据初始化
        handles.imgC=uint8(imread(str));    % 图像数据        
   % 图像尺寸处理
        % 检索图像的尺寸
        [Chight,Cwidth]=size(handles.imgC);      
        % 检索尺寸最大值
        handles.N=max([Chight,Cwidth,handles.N]);         
        % 构造三个全为1的N阶方阵
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % 将A,B,C图像分别放到N阶方阵中
        [Ahight,Awidth]=size(handles.imgA);
        tempA(1:Ahight,1:Awidth)=handles.imgA;
        [Bhight,Bwidth]=size(handles.imgB);
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        tempC(1:Chight,1:Cwidth)=handles.imgC;            
        % 再分别赋值给全局变量
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC(); 
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % 更新结构体数据
        guidata(hObject, handles);
   % 控件初始化
        % 更新图像
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % 打开相关使能
        set(handles.C_p,'enable','on');
end


%% 更新C图像
function PB_UpData_C_Callback(hObject, eventdata, handles)
% 更新C图像
% 执行图像运算
    %   1   2   3   4   5     6    7     8    9
    % {'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'}
    switch get(handles.C_algorithm,'value')
        case 1
            handles.imgC=handles.p+handles.q;
        case 2
            handles.imgC=handles.p-handles.q;
        case 3
            handles.imgC=handles.p .* handles.q;
        case 4
            handles.imgC=handles.p ./ handles.q;
        case 5
            handles.imgC=handles.p .* handles.q;
        case 6
            handles.imgC=handles.p+handles.q;
        case 7
            temp=handles.p+handles.q;
            temp(temp>500)=0;
            handles.imgC=temp;
        case 8
            if get(handles.C_p,'value')==4   
                handles.imgC=255-handles.q;
            else
                hs=msgbox('语法错误!','错误','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end    
        case 9
            if get(handles.C_p,'value') == 4
                handles.imgC= handles.q;     
            else                 
                hs=msgbox('语法错误!','错误','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);  
                uiwait(hs);
            end
    end
% 更新结构体数据
    guidata(hObject, handles);
    % 设置图像显示区域
    axes(handles.axes3);         
    % 显示图像
    imshow(uint8(handles.imgC));
% 设置相关使能
    set(hObject,'enable','off');
    set(handles.C_p,'enable','on');
    set(handles.C_algorithm,'enable','off');
    set(handles.C_q,'enable','off');
    set(handles.PB_Recover_C,'enable','on');


%% C_p 赋值    
function C_p_Callback(hObject, eventdata, handles)
% C_p 赋值 
    %   1   2   3   4
    % {'A';'B';'C';'_'}
    switch get(hObject,'value')
        case 1
            handles.p=handles.imgA;
        case 2
            handles.p=handles.imgB;
        case 3
            handles.p=handles.imgC;
        case 4
            handles.p=repmat(255,handles.N,handles.N);
    end
% 打开相关使能
    set(handles.C_algorithm,'enable','on');
% 更新结构体数据
    guidata(hObject, handles);
  

%% C_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值    
function C_algorithm_Callback(hObject, eventdata, handles)
% C_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} 赋值
% 打开相关使能
    set(handles.C_q,'enable','on');


%% C_q 赋值    
function C_q_Callback(hObject, eventdata, handles)
% C_q 赋值
    %   1   2   3 
    % {'A';'B';'C'}  
    switch get(hObject,'value')
        case 1
            handles.q=handles.imgA;
        case 2
            handles.q=handles.imgB;
        case 3
            handles.q=handles.imgC;
    end
% 打开相关使能
    set(handles.PB_UpData_C,'Enable','on');
% 更新结构体数据
    guidata(hObject, handles);
    
    
%% 将B赋值给C
% 
% <<__B.bmp>>
% 

%% 将A取反后赋值给B
%
% <<_NOTA.bmp>>
% 

%% 将A加B后赋值给C
%
% <<A+B.bmp>>
%

%%
%
% <<AB+.bmp>>
%

%% 将B异或C后赋值给A
%
% <<BXORC.bmp>>
% 
