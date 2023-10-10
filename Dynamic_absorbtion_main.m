clear
clc
close all
M=325;% 薄膜宽度
N=325;% 薄膜长度
sol_tot=3240;% 总浓度
Time=400;% 仿真总时长
step=1;% 仿真步长
Pa=1E-4;% 吸附概率
Pd=6E-4;% 脱离概率
S=0.8;



metal_mat=zeros(M,N);%状态矩阵
a=ones(M,N);%颜色矩阵初始值
figure(1)
% subplot(121)
% imh=image(cat(3,a,a,a));
% axis equal;
% axis tight;
% set(gca,'xtick',[],'ytick',[])
% grid on;
% set(gca,'GridLineStyle','-','LineWidth',1,'FontSize',1,'GridColor','k','GridAlpha',1);
% set(gca,'YDir','normal')
% xlim([0.5,10.5])
% ylim([0.5,10.5])
txt = uicontrol('style','text', ...
    'string','sol_now:', ...
    'fontsize',12, ...
    'position',[80,60,70,20]);
txt2 = uicontrol('style','text', ...
    'string','site:', ...
    'fontsize',12, ...
    'position',[80,80,70,20]);
txt3 = uicontrol('style','text', ...
    'string','sol_tot:', ...
    'fontsize',12, ...
    'position',[80,100,70,20]);
number = uicontrol('style','text', ...
    'string',num2str(sol_tot), ...
    'fontsize',12, ...
    'position',[160,60,70,20]);
number2 = uicontrol('style','text', ...
    'string',num2str(0), ...
    'fontsize',12, ...
    'position',[160,80,70,20]);
number3 = uicontrol('style','text', ...
    'string',num2str(sol_tot), ...
    'fontsize',12, ...
    'position',[160,100,70,20]);

sol_now=sol_tot;
sol_now_all=sol_now;
% subplot(122)
title('The change of ion concentration with simulation time')
ylabel('ion concentration')
xlabel('Simulation time')
h=line(1:length(sol_now_all),sol_now_all,'linesty','-','color','k');
xlim([0,Time])
ylim([0,sol_tot])
figure(2)
imh2=image(cat(3,a,a,a));
set(gca,'xtick',[],'ytick',[])
for t=step:step:Time
    metal_mat_pre=metal_mat;
    sol_now_pre=sol_now;
    %% 计算
    for i=1:M
        for j=1:N
            if metal_mat(i,j)==0
                o=0;% 已吸附点位数
%                 S=sum(sum(metal_mat))/(M*N);
                loca=cell_search(i,j,M,N);
                for k=1:size(loca,1)
                    o=o+metal_mat(loca(k,1),loca(k,2));
                end
                N_R1=rand(1);
                N_=N_R1*(1+o/(8*S))*sol_tot/sol_now;
                if N_<Pa
                    metal_mat_pre(i,j)=1;% 点位置为1
                    sol_now_pre=sol_now_pre-1;% 浓度减1
                end
            else
                N_R2=rand(1);
                if N_R2<Pd
                    metal_mat_pre(i,j)=0;% 点位重置为0
                    sol_now_pre=sol_now_pre+1;% 浓度加1
                end
            end
        end
    end
    metal_mat=metal_mat_pre;% 更新状态矩阵
    sol_now=sol_now_pre; % 更新浓度
    sol_now_all=[sol_now_all,sol_now];
    %% 更新与绘图
    a1=a; a2=a;a3=a;%重置颜色矩阵
%     set(imh,'cdata', cat(3,a1,a2,a3))
    for i=1:M
        for j=1:N
            if metal_mat(i,j)==1
                a1(i,j)=0; a2(i,j)=0.7; a3(i,j)=0;
            end
        end
    end
%     set(imh,'cdata', cat(3,a1,a2,a3))
    set(imh2,'cdata', cat(3,a1,a2,a3))
    set(number,'string',num2str(sol_now));
    set(number2,'string',num2str(sum(sum(metal_mat))));
    set(number3,'string',num2str(sol_now+sum(sum(metal_mat))));
    set(h,'xdata',1:length(sol_now_all),'ydata',sol_now_all);
    pause(0.01)
end
            
    
