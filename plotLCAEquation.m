power=linspace(8.33,12.5,16);
LCA_val=0.019*power.^2-0.5379*power+4.1326;
% slope=2*0.019*power-0.5379;
figure(1),plot(power,LCA_val,'o--');
xlabel('optotune power');
ylabel('LCA');
%  figure(2),plot(power,slope);
powerv=[8 8.005 8.1 8.3 8.05 8.045] ;
LCA_valv=0.019*powerv.^2-0.5379*powerv+4.1326;
diff=[LCA_valv(1)-LCA_valv(2)  LCA_valv(1)-LCA_valv(3)  LCA_valv(1)-LCA_valv(4)  LCA_valv(1)-LCA_valv(5) LCA_valv(1)-LCA_valv(6)]

powerv=[11 11.005 11.1 11.3 11.05 11.045] ;
LCA_valv=0.019*powerv.^2-0.5379*powerv+4.1326;
diff=[LCA_valv(1)-LCA_valv(2)  LCA_valv(1)-LCA_valv(3)  LCA_valv(1)-LCA_valv(4)  LCA_valv(1)-LCA_valv(5) LCA_valv(1)-LCA_valv(6)]

powerv=[12.5 12.505 12.6 12.8 12.55 12.545] ;
LCA_valv=0.019*powerv.^2-0.5379*powerv+4.1326;
diff=[LCA_valv(1)-LCA_valv(2)  LCA_valv(1)-LCA_valv(3)  LCA_valv(1)-LCA_valv(4)  LCA_valv(1)-LCA_valv(5) LCA_valv(1)-LCA_valv(6)]

