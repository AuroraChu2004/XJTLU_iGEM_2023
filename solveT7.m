clear
OD = 1;
ODunit = 8E+8;
b1 = 0.002706;% 把启动子换算成浓度，速率常数k为6.116（厄瓜多尔） 
LacItot = 0.01;% may be related to the numebr of E.coil  uM the other data is 498?
ytotal =600;% induce
kinput=0.92;
koutput=0.05;
di=8.25E-5.*60;
n = 2;% hill cofficient
K_degration2 = 0.462 ;%min-1
r_degration2 = 0.2 ;%min-1
b2=0.0206;%BL21:0.755 JF1:0.075
K_degration=4.4E-3*60;%SmtA:1.69E-3*60;
K_transcribtion=0.57*60; %CsgA:0.57*60;
r_degration=6.3E-5*60;%CsgA:6.3E-5*60;
r_transfer = 1.8E-4*60; % min-1
a0=0.01;
a1=0.01;
rdeg2=0.000385;
[t,y] = ode45(@(t,y) T7proProduction_formular(y,b1,kinput,ytotal,koutput,LacItot,di, ...
    K_degration2,r_degration2,b2,n,K_degration,K_transcribtion, ...
    r_degration,r_transfer,rdeg2),0:1440,[0,0,0,0,0,0]);
plot(t,y(:,5),"LineWidth",2.5)
hold on
plot(t,y(:,6),'LineWidth',2.5)
xlabel('time/min');
ylabel('csgA-AG4 concentration/μM');
legend('csgA-AG4 inside the cell', 'CsgA-AG4 transferred out of the cell');
title(['Relationship between protein production and time at IPTG concentration of 0.6mM']);
grid on;