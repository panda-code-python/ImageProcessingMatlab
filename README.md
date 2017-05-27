<style>
   h1{color:#ff0000;text-align: center;}
   h2{text-align: center;}
   html body { margin:5%;｝
</style>


# 基于Matlab的图像处理软件

&nbsp;&nbsp;&nbsp;&nbsp;本项目是自己根据所学的《图像处理》课程内容基于Matlab GUI编程实现一些基本的图像处理算法，
原本有一个主程序，但目前完成的内容比较少，所以直接单独列出各个模块了，有空再完善一下。实现
的功能比较简单，主要是为了练习一下Matlab的GUI编程以及实现图像处理的一些基本算法。

## 相关子函数
   [myHisteq()](https://zhangqunwei.github.io/ImageProcessingMatlab/source/html/myHisteq.html)
   [myim2bw()](https://zhangqunwei.github.io/ImageProcessingMatlab/source/html/myim2bw.html)
   [myordfilt2()](https://zhangqunwei.github.io/ImageProcessingMatlab/source/html/myordfilt2.html)
   
## sobal算子
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/source/sobal.html)
{% highlight Matlab %}  
% 说明：用Matlab的实时编辑器打开运行
% sobal算子
% 1、设置算子

plateX=[-1 -2 -1;0 0 0;1 2 1];
plateY=[-1 0  1;-2 0 2;-1 0 1];
% 2、读取并显示原图

X=imread('cameraman.tif');
figure
imshow(X);

X=double(X);
[height,width]=size(X);     % 检索图像大小
% 3、计算dx即X方向
N=size(plateX,1);           % 检索模板大小
dX=X;                       % 保存计算后的图像（double类型）
for i=1:height-2
    for j=1:width-2
        % 模板卷积运算
        temp=plateX.*X(i:i+(N-1),j:j+(N-1)); % 模板与图像数据点乘
        temp=sum(sum(temp));                % 求和
        % 平方并写入图像
        dX(i:i+(N-1)/2,j:j+(N-1)/2)=temp.^2;
    end
end
{% endhighlight %} 




## 点操作
### 1.图像灰度映射 
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/html/点操作/图像灰度映射/DCZTuXiangHuiDuYingShe.html)
 
{% highlight Matlab %}  
%% 点操作---图像灰度映射
% * 概述      ：主要实现图像典型的灰度映射
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[9/5/2017]  
%%

%%
%
% <<main.bmp>>
%

%% 主函数
% *不做任何修改*
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
.
.
.
{% endhighlight %}  
 
 
### 2.图像间运算
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/html/点操作/图像间运算/DCZTuXiangJianYunSuan.html)
 
{% highlight Matlab %}  
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
.
.
.
{% endhighlight %}  


### 3.直方图均衡化
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/html/点操作/直方图均衡化/DCZZhiFangTuBianHuan.html)
 
{% highlight Matlab %}  
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
{% endhighlight %}  


### 4.坐标变换 
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/html/点操作/坐标变换/DCZZuoBiaoBianHuan.html)
 
{% highlight Matlab %}  
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
.
.
.
{% endhighlight %}  


## 模板操作
### 1.模板运算
 [查看源码](https://zhangqunwei.github.io/ImageProcessingMatlab/html/模板操作/模板运算/MBCZMoBanYunSuan.html)
 
{% highlight Matlab %}  
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
.
.
.
{% endhighlight %}  
