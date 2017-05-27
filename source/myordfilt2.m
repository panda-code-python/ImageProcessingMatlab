%% 二维顺序统计量滤波函数
% * 概述      ：它的滤波概念是中值滤波的推广，中值滤波是对于给定的n个数值
%               {al ,a2,...,an}，将它们按大小顺序排列，取中间的那个值作为
%               滤波器的输出。而在myordfilt2函数中的二维顺序统计量滤波将n个
%               非零数值按小到大排序后处于第k个位置的元素作为滤波器的输出。
% * 作者		：张群伟	南昌航空大学信息工程学院自动化系
% * 日期		：[10/5/2017]  
%%


%% 函数说明
%%
% *参数说明：*
%_ A       需要滤波的源图像
%_ order   序号
%_ domain  滤波窗口大小 
%%
% *使用举例：*
%_ I=myordfilt2(X,1,3);        % 相当于模板为3×3的最小值滤波
%_ I=myordfilt2(X,5,3);        % 相当于模板为3×3的中值滤波
%_ I=myordfilt2(X,9,3);        % 相当于模板为3×3的最大值滤波
%_ I=myordfilt2(X,12,5);       % 模板为5×5，取序号为12的灰度值



%% 主函数
% *实现图像的二维顺序统计量滤波*
function B=myordfilt2(A,order,domain)	
[ah,aw]=size(A);
for i=1:ah-domain
    for j=1:aw-domain
        % 取出图像中与模版对应的数据
        temp=A(i:i+(domain-1),j:j+(domain-1));  
        % 将矩阵转变为一个矢量
        s=temp(:);  
        % 从小到大排序
        med=sort(s);     
        % 将order指定的值写入中心位置
        A(i:i+(domain-1)/2,j:j+(domain-1)/2)=med(order);
    end
end
% 返回
B=A;
    
