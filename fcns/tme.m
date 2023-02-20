function c3=tme()
%year month day hour minute 
c=clock;
c1=c(5)+c(4)*1E2+c(3)*1E4+c(2)*1E6+c(1)*1E8; 
c2=num2str(c1);
c3=c2(3:end);
