clear
b1 = 0.0072;% the maximum speed of hill equation uM*min-1   
Kx1 = 0.00005;%uM
Kr1 = 1;% uM
LacItot = 0.01;% may be related to the numebr of E.coil  uM the other data is 498?
%IPTG = 50.*0.944415;% induce
n = 2;% hill cofficient
rm = 4.4E-3.* 60;%min-1
rp = 6.3E-5.* 60;%min-1
ktr = 0.57.* 60;%min-1
kt = 1.8E-4.* 60; % min-1
ytotal=400;
kinput=0.92;
koutput=0.05;
di=8.25E-5.*60;
rdeg2=0.000385;
[t,y] = ode45(@(t,y) proProduction(ytotal,kinput,koutput,di,b1,Kx1,Kr1,LacItot,n,rm,rp,ktr,y,kt,rdeg2),0:50:1440,[0,0,0,0]);
plot(t,y(:,3),'LineWidth',2)
legend("protein in cell");
hold on
plot(t,y(:,4),'LineWidth',2)
%legend("protein transferred out of the cell")
title("Relationship between protein production and time at IPTG concentration of 0.4mM","FontSize",16);
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times');
xlabel("time/min","FontSize",16);
ylabel("CsgA-AG4 concentration/μMl","FontSize",16);
legend('CsgA-AG4 inside the cell','CsgA-AG4 transferred out of the cell');
grid on;
