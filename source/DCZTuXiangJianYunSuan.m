%% �����---ͼ�������
% * ����      ��ʵ��ͼ�����������߼�����
% * ����		����Ⱥΰ	�ϲ����մ�ѧ��Ϣ����ѧԺ�Զ���ϵ
% * ����		��[4/5/2017]
%%

%%
%
% <<main.bmp>>
%

%% ������
% *�����κ��޸�*
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


%% ��ʼ����
% *��س�ʼ��*
function DCZTuXiangJianYunSuan_OpeningFcn(hObject, eventdata, handles, varargin)
% ȫ�ֱ���
    % N�׷���
    handles.N=0;
    % Aͼ��
    handles.imgA_old=0;      % Aͼ���ַ
    handles.imgA=0;          % Aͼ������
    % Bͼ��
    handles.imgB_old=0;      % Bͼ���ַ
    handles.imgB=0;          % Bͼ������
    % Cͼ��
    handles.imgC_old=0;      % Cͼ���ַ
    handles.imgC=0;          % Cͼ������          
    % p,  q,  op����
    handles.p=0;
    handles.q=0;
    handles.op=0;
% �ؼ���ʼ��
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


%% �������
function DCZTuXiangJianYunSuan_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
% varargout{1} = handles.output;
%


%% �ָ�Aͼ��
function PB_Recover_A_Callback(hObject, eventdata, handles)
% �ָ�Aͼ��
    handles.imgA=handles.imgA_old;
% ���½ṹ������
    guidata(hObject, handles);
% ����ͼ����ʾ����
    axes(handles.axes1);
    imshow(uint8(handles.imgA));
   

%% ����Aͼ��    
function PB_Load_A_Callback(hObject, eventdata, handles)
% ����Aͼ��  
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index 
    str=[pname fname];    
end
if str~=' '
   % ���ݳ�ʼ��
        handles.imgA=uint8(imread(str));    % ͼ������
   % ͼ��ߴ紦��
        % ����ͼ��ĳߴ�
        [Ahight,Awidth]=size(handles.imgA);
        % �����ߴ����ֵ
        handles.N=max([Ahight,Awidth,handles.N]);
        % ��������ȫΪ1��N�׷���
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % ��A,B,Cͼ��ֱ�ŵ�N�׷�����
        tempA(1:Ahight,1:Awidth)=handles.imgA;
        [Bhight,Bwidth]=size(handles.imgB);
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        [Chight,Cwidth]=size(handles.imgC);
        tempC(1:Chight,1:Cwidth)=handles.imgC;
        % �ٷֱ�ֵ��ȫ�ֱ���
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC();
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % ���½ṹ������
        guidata(hObject, handles);
   % �ؼ���ʼ��
        % ����ͼ��
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % �����ʹ��
        set(handles.A_p,'enable','on');
end
 

%% ����Aͼ��   
function PB_UpData_A_Callback(hObject, eventdata, handles)
% ����Aͼ�� 
% ִ��ͼ������
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
                hs=msgbox('�﷨����!','����','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end
        case 9
            if get(handles.A_p,'value') == 4
                handles.imgA= handles.q;     
            else
                h=msgbox('�﷨����!','����','error');uiwait(h);
                ht=findobj(h,'type','text');
                set(ht,'FontSize',16);                       
            end
    end
% ���½ṹ������
    guidata(hObject, handles);
    % ����ͼ����ʾ����
    axes(handles.axes1);        
    % ��ʾͼ��
    imshow(uint8(handles.imgA));
% �������ʹ��
    set(hObject,'enable','off');
    set(handles.A_p,'enable','on');
    set(handles.A_algorithm,'enable','off');
    set(handles.A_q,'enable','off');
    set(handles.PB_Recover_A,'enable','on');


%% A_p ��ֵ    
function A_p_Callback(hObject, eventdata, handles)
% A_p ��ֵ
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
% �����ʹ��
    set(handles.A_algorithm,'enable','on');
% ���½ṹ������
    guidata(hObject, handles);

    
%% A_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ
function A_algorithm_Callback(hObject, eventdata, handles)
% A_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ
% �����ʹ��
    set(handles.A_q,'enable','on');    


%% A_q ��ֵ    
function A_q_Callback(hObject, eventdata, handles)
% A_q ��ֵ
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
% �����ʹ��
    set(handles.PB_UpData_A,'Enable','on');
% ���½ṹ������
    guidata(hObject, handles);


%% �ָ�Bͼ��
function PB_Recover_B_Callback(hObject, eventdata, handles)
% �ָ�Bͼ��
    handles.imgB=handles.imgB_old;
% ���½ṹ������
    guidata(hObject, handles);
% ����ͼ����ʾ����
    axes(handles.axes2);
    imshow(uint8(handles.imgB));
    

%% ����Bͼ��    
function PB_Load_B_Callback(hObject, eventdata, handles)
% ����Bͼ�� 
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index 
    str=[pname fname];    
end
if str~=' '
   % ���ݳ�ʼ��
        handles.imgB=uint8(imread(str));    % ͼ������
   % ͼ��ߴ紦��
        % ����ͼ��ĳߴ�
        [Bhight,Bwidth]=size(handles.imgB);      
        % �����ߴ����ֵ
        handles.N=max([Bhight,Bwidth,handles.N]);
        % ��������ȫΪ1��N�׷���
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % ��A,B,Cͼ��ֱ�ŵ�N�׷�����
        [Ahight,Awidth]=size(handles.imgA);
        tempA(1:Ahight,1:Awidth)=handles.imgA;            
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        [Chight,Cwidth]=size(handles.imgC);
        tempC(1:Chight,1:Cwidth)=handles.imgC;
        % �ٷֱ�ֵ��ȫ�ֱ���
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC();
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % ���½ṹ������
        guidata(hObject, handles);
   % �ؼ���ʼ��
        % ����ͼ��
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % �����ʹ��
        set(handles.B_p,'enable','on');
end
   

%% ����Bͼ��
function PB_UpData_B_Callback(hObject, eventdata, handles)
% ����Bͼ��
% ִ��ͼ������
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
                hs=msgbox('�﷨����!','����','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end
        case 9
            if get(handles.B_p,'value') == 4
                handles.imgB= handles.q;     
            else
                h=msgbox('�﷨����!','����','error');
                ht=findobj(h,'type','text');
                set(ht,'FontSize',16);  
                uiwait(h);
            end
    end
% ���½ṹ������
    guidata(hObject, handles);
    % ����ͼ����ʾ����
    axes(handles.axes2);         
    % ��ʾͼ��
    imshow(uint8(handles.imgB));
% �������ʹ��
    set(hObject,'enable','off');
    set(handles.B_p,'enable','on');
    set(handles.B_algorithm,'enable','off');
    set(handles.B_q,'enable','off');
    set(handles.PB_Recover_B,'enable','on');


%% B_p ��ֵ    
function B_p_Callback(hObject, eventdata, handles)
% B_p ��ֵ 
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
% �����ʹ��
    set(handles.B_algorithm,'enable','on');
% ���½ṹ������
    guidata(hObject, handles);
 

%% B_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ    
function B_algorithm_Callback(hObject, eventdata, handles)
% B_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ
% �����ʹ��
    set(handles.B_q,'enable','on');


%% B_q ��ֵ    
function B_q_Callback(hObject, eventdata, handles)
% B_q ��ֵ
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
% �����ʹ��
    set(handles.PB_UpData_B,'Enable','on');
% ���½ṹ������
    guidata(hObject, handles);


%% �ָ�Cͼ��
function PB_Recover_C_Callback(hObject, eventdata, handles)
% �ָ�Cͼ�� 
    handles.imgC=handles.imgC_old;
% ���½ṹ������
    guidata(hObject, handles);
% ����ͼ����ʾ����
    axes(handles.axes3);
% ��ʾͼ��
    imshow(uint8(handles.imgC));
 

%% ����Cͼ��    
function PB_Load_C_Callback(hObject, eventdata, handles)
% ����Cͼ��
str=' ';
[fname,pname,index]=uigetfile({'*.bmp';'*.jpg'},'ѡ��ͼƬ');
if index 
    str=[pname fname];    
end
if str~=' '
   % ���ݳ�ʼ��
        handles.imgC=uint8(imread(str));    % ͼ������        
   % ͼ��ߴ紦��
        % ����ͼ��ĳߴ�
        [Chight,Cwidth]=size(handles.imgC);      
        % �����ߴ����ֵ
        handles.N=max([Chight,Cwidth,handles.N]);         
        % ��������ȫΪ1��N�׷���
        tempA=ones(handles.N);
        tempB=tempA;
        tempC=tempA;
        % ��A,B,Cͼ��ֱ�ŵ�N�׷�����
        [Ahight,Awidth]=size(handles.imgA);
        tempA(1:Ahight,1:Awidth)=handles.imgA;
        [Bhight,Bwidth]=size(handles.imgB);
        tempB(1:Bhight,1:Bwidth)=handles.imgB;
        tempC(1:Chight,1:Cwidth)=handles.imgC;            
        % �ٷֱ�ֵ��ȫ�ֱ���
        handles.imgA=tempA();
        handles.imgB=tempB();
        handles.imgC=tempC(); 
        handles.imgA_old=tempA();
        handles.imgB_old=tempB();
        handles.imgC_old=tempC();
   % ���½ṹ������
        guidata(hObject, handles);
   % �ؼ���ʼ��
        % ����ͼ��
        axes(handles.axes1);
        imshow(uint8(handles.imgA));
        axes(handles.axes2);
        imshow(uint8(handles.imgB));
        axes(handles.axes3);
        imshow(uint8(handles.imgC));
        % �����ʹ��
        set(handles.C_p,'enable','on');
end


%% ����Cͼ��
function PB_UpData_C_Callback(hObject, eventdata, handles)
% ����Cͼ��
% ִ��ͼ������
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
                hs=msgbox('�﷨����!','����','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);
                uiwait(hs);
            end    
        case 9
            if get(handles.C_p,'value') == 4
                handles.imgC= handles.q;     
            else                 
                hs=msgbox('�﷨����!','����','error');
                ht=findobj(hs,'type','text');
                set(ht,'FontSize',16);  
                uiwait(hs);
            end
    end
% ���½ṹ������
    guidata(hObject, handles);
    % ����ͼ����ʾ����
    axes(handles.axes3);         
    % ��ʾͼ��
    imshow(uint8(handles.imgC));
% �������ʹ��
    set(hObject,'enable','off');
    set(handles.C_p,'enable','on');
    set(handles.C_algorithm,'enable','off');
    set(handles.C_q,'enable','off');
    set(handles.PB_Recover_C,'enable','on');


%% C_p ��ֵ    
function C_p_Callback(hObject, eventdata, handles)
% C_p ��ֵ 
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
% �����ʹ��
    set(handles.C_algorithm,'enable','on');
% ���½ṹ������
    guidata(hObject, handles);
  

%% C_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ    
function C_algorithm_Callback(hObject, eventdata, handles)
% C_{'+';'-';'*';'/';'AND';'OR';'XOR';'NOT';'_'} ��ֵ
% �����ʹ��
    set(handles.C_q,'enable','on');


%% C_q ��ֵ    
function C_q_Callback(hObject, eventdata, handles)
% C_q ��ֵ
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
% �����ʹ��
    set(handles.PB_UpData_C,'Enable','on');
% ���½ṹ������
    guidata(hObject, handles);
    
    
%% ��B��ֵ��C
% 
% <<__B.bmp>>
% 

%% ��Aȡ����ֵ��B
%
% <<_NOTA.bmp>>
% 

%% ��A��B��ֵ��C
%
% <<A+B.bmp>>
%

%%
%
% <<AB+.bmp>>
%

%% ��B���C��ֵ��A
%
% <<BXORC.bmp>>
% 
