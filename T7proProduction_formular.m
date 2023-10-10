function dydt = T7proProduction_formular(y,b1,kinput,ytotal,koutput,LacItot,di, ...
    K_degration2,r_degration2,b2,n,K_degration,K_transcribtion, ...
    r_degration,r_transfer,rdeg2)
  dydt = zeros(6,1);
  dydt(1)=kinput.*(ytotal-y(1))-koutput.*y(1)-y(1).*di;
  dydt(2) = b1./ (1 + ((LacItot./0.00005) .*(1 ./(1 + (y(1).^n)./1))))-K_degration2.*y(1);%这个Kx是开过根号的还是没开过的
  dydt(3) = 0.5.*y(1)-r_degration2.*y(3);
  dydt(4) = b2.*y(3).^2./(3+y(3).^2)-K_degration.*y(4);%dydt(3)=b2.*y(2)-K_degration.*y(3);
  dydt(5) = K_transcribtion.*y(4)-r_degration.*y(5)-r_transfer.*y(5);
  dydt(6) = r_transfer.*y(5)-rdeg2.*y(6);
end
