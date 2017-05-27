%% 直方图均衡化函数
% * 概述      ：对图像进行直方图均衡化
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[10/5/2017]  
%%


%% 函数说明
%%
% *参数说明：*
%_ src_img       需要均衡化的源图像

%%
% *使用举例：*
%_ Y=myHisteq(I);          对图像I进行直方图均衡化，将结果返回给Y
%_ [Y,Sk]=myHisteq(I);     获取直方图均衡化后的结果、原始直方图
%_ [Y,Sk,Tk]=myHisteq(I);  获取直方图均衡化后的结果、原始直方图、累计直方图

%% 主函数
% *对图像进行直方图均衡化*
function [I,varargout]=myHisteq(src_img) 
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
% 原始直方图 （Original histogram ）
    Sk=zeros(1,256);
    for i=1:256
        Sk(i)=pixelNum(i)/(height*width*1.0);
    end
    varargout{1}=Sk;
% 累计直方图 （Cumulative histogram） 
    Tk=zeros(1,256);% 保存累积后的概率
    for i = 1:256
        if i==1
            Tk(i)=Sk(i);
        else
            Tk(i)=Tk(i-1)+Sk(i);
        end
    end
    varargout{2}=Tk;
% 取整扩展（Integral expansion） 
% 公式： pixelCumu = int[(L-1)*pixelCumu+0.5]（L为灰度级）
	Tk(i) = uint8((256-1) .* Tk(i) + 0.5);
% 对灰度值进行映射
    for i=1:height
        for j=1:width
            I(i,j)=Tk(src_img(i,j)+1);
        end
    end
% 返回
    I=double(I);

