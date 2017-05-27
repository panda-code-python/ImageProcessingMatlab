%% ֱ��ͼ���⻯����
% * ����      ����ͼ�����ֱ��ͼ���⻯
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[10/5/2017]  
%%


%% ����˵��
%%
% *����˵����*
%_ src_img       ��Ҫ���⻯��Դͼ��

%%
% *ʹ�þ�����*
%_ Y=myHisteq(I);          ��ͼ��I����ֱ��ͼ���⻯����������ظ�Y
%_ [Y,Sk]=myHisteq(I);     ��ȡֱ��ͼ���⻯��Ľ����ԭʼֱ��ͼ
%_ [Y,Sk,Tk]=myHisteq(I);  ��ȡֱ��ͼ���⻯��Ľ����ԭʼֱ��ͼ���ۼ�ֱ��ͼ

%% ������
% *��ͼ�����ֱ��ͼ���⻯*
function [I,varargout]=myHisteq(src_img) 
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
% ԭʼֱ��ͼ ��Original histogram ��
    Sk=zeros(1,256);
    for i=1:256
        Sk(i)=pixelNum(i)/(height*width*1.0);
    end
    varargout{1}=Sk;
% �ۼ�ֱ��ͼ ��Cumulative histogram�� 
    Tk=zeros(1,256);% �����ۻ���ĸ���
    for i = 1:256
        if i==1
            Tk(i)=Sk(i);
        else
            Tk(i)=Tk(i-1)+Sk(i);
        end
    end
    varargout{2}=Tk;
% ȡ����չ��Integral expansion�� 
% ��ʽ�� pixelCumu = int[(L-1)*pixelCumu+0.5]��LΪ�Ҷȼ���
	Tk(i) = uint8((256-1) .* Tk(i) + 0.5);
% �ԻҶ�ֵ����ӳ��
    for i=1:height
        for j=1:width
            I(i,j)=Tk(src_img(i,j)+1);
        end
    end
% ����
    I=double(I);

