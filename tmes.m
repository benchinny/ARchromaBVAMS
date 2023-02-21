function c3=tmes()
%year month day hour minute second
c=clock;
% c1=c(5)+c(4)*1E2+c(3)*1E4+c(2)*1E6+c(1)*1E8; 
c1=round(c(6))+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10; 
c2=num2str(c1);
c3=c2(3:end);