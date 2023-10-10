IPTG=0:50:1000;
lac=0.002706./ (1 + ((0.01./0.00005) .*(1 ./(1 + (IPTG.^2)./1))));
mrnacsga=0.755.*((0.5.*lac)./(0.2.*0.462)).^2./(3.^2+((0.5.*lac)./(0.2.*0.462)).^2);
plot(IPTG.*0.9485,mrnacsga,"LineWidth",2)
xlabel('IPTG concentration (μM)')
ylabel('production of mRNA·CsgA-AG4 (μM)')
