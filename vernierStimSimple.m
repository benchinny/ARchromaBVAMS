function I = vernierStimSimple(sizeXY,ctrXY,x,y)

% function I = vernierStimSimple(sizeXY,ctrXY,x,y)
%
% example call: I = vernierStimSimple([100 100],[50 75; 50 25],[2 2],[24 24]);
%               I = vernierStimSimple([100 100],[50 75; 53 25],[2 2],[24 24]);
%               I = vernierStimSimple([100 100],[50 75; 47 25],[2 2],[24 24]);

I = zeros(sizeXY);

for i = 1:size(ctrXY,2)
    I((ctrXY(i,2)-y(i)):(ctrXY(i,2)+y(i)),(ctrXY(i,1)-x(i)):(ctrXY(i,1)+x(i))) = 1;
end

end