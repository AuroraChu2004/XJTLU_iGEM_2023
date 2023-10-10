function dydt = proProduction(ytotal,kinput,koutput,di,b1,Kx1,Kr1,LacItot,n,rm,rp,ktr,y,kt,rdeg2)
dydt = zeros(4,1);
dydt(1)=kinput.*(ytotal-y(1))-koutput.*y(1)-y(1).*di;
dydt(2) = b1 ./ (1 + ((LacItot./Kx1) .*(1 ./(1 + (y(1).^n)./Kr1)))) - rm.*y(2);
dydt(3) = ktr.*y(2) - rp.*y(3) - kt.*y(3);
dydt(4) = kt.*y(3)-rdeg2.*y(4);
end