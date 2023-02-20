%% generate oval window
function [wn, vbl1]=owin(ey, cf, vd, lineWidthpix, allCoords, vbl0, window1, window2)
global black white grey screenXpixels screenYpixels xCenter yCenter squareX squareY ifi
%vd=[rd kd bd] vector of diameters
rr = [0 0 vd(1) vd(1)];
kr = [0 0 vd(2) vd(2)];
br = [0 0 vd(3) vd(3)];

rc = CenterRectOnPointd(rr, xCenter, yCenter);
kc = CenterRectOnPointd(kr, xCenter, yCenter);
%bc = CenterRectOnPointd(br, xCenter, yCenter);
bc = CenterRectOnPointd(br, squareX, squareY);


cc=[rc; kc]'; 


rectColor=[1 0 0; 0 0 0]';

waitframes=1;

switch ey
    case 'Stereo'
        
        ovl(window1, rectColor.*cf(1), cc, allCoords, lineWidthpix, [xCenter yCenter]);
        ovl(window2, rectColor.*cf(2), cc, allCoords, lineWidthpix, [xCenter yCenter]);
        
        ovl(window1, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);
        ovl(window2, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);

        
%            % Draw the rect to the screen
%           Screen('FillOval', window1, rectColor, cc);
%           Screen('FillOval', window2, rectColor, cc);
% 
%           Screen('DrawLines', window1, allCoords, lineWidthPix, black, [xCenter yCenter], 2);
%           Screen('DrawLines', window2, allCoords, lineWidthPix, black, [xCenter yCenter], 2);
%             
%           Screen('FillOval', window1, [0 0 1], bc);
%           Screen('FillOval', window2, [0 0 1], bc);
% 
%           Screen('DrawLines', window1, ab, lineWidthPix, black, [squareX squareY], 2);
%           Screen('DrawLines', window2, ab, lineWidthPix, black, [squareX squareY], 2);

          % Flip to the screen
          vbl1(1) = Screen('Flip', window1, vbl0(1) + (waitframes - 0.5) * ifi);
          vbl1(2)  = Screen('Flip', window2, vbl0(2) + (waitframes - 0.5) * ifi); 
          
          wn='B'

    case 'Right'
        
        
        ovl(window1, rectColor.*cf(1), cc, allCoords, lineWidthpix, [xCenter yCenter]);        
        ovl(window1, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);      
        vbl1(1)  = Screen('Flip', window1, vbl1(1) + (waitframes - 0.5) * ifi);
        wn='R'
        
    case 'Left'
        
        ovl(window2, rectColor.*cf(2), cc, allCoords, lineWidthpix, [xCenter yCenter]);
        ovl(window2, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);
        vbl1(2)  = Screen('Flip', window2, vbl0(2) + (waitframes - 0.5) * ifi);
        wn='L'
    case 'Random'
        if rand<0.5
        ovl(window1, rectColor.*cf(1), cc, allCoords, lineWidthpix, [xCenter yCenter]);        
        ovl(window1, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);      
        vbl1(1)  = Screen('Flip', window1, vbl1(1) + (waitframes - 0.5) * ifi);
        wn='R'
        else
        ovl(window2, rectColor.*cf(2), cc, allCoords, lineWidthpix, [xCenter yCenter]);
        ovl(window2, [0 0 1], bc, allCoords, lineWidthpix, [squareX squareY]);
        vbl1(2)  = Screen('Flip', window2, vbl0(2) + (waitframes - 0.5) * ifi);
        wn='L'
        end      
end