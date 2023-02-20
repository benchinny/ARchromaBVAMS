

function ovl(window, rectColor, cc, allCoords, lineWidthpix, xyc)
global black white grey screenXpixels screenYpixels ifi cf
% draw oval & lines

% cc =circle/rectangle center

% % Now we set the coordinates (these are all relative to zero we will let
% % the drawing routine center the cross in the center of our monitor for us)
% xCoords = [-screenXpixels/2 screenXpixels/2 0 0];
% yCoords = [0 0 -screenYpixels screenYpixels];
% allCoords = [xCoords; yCoords];

% 2 - good quality anti-aliasing

            Screen('FillOval', window, rectColor, cc);
            Screen('DrawLines', window, allCoords, lineWidthPix, black, xyc, 2);