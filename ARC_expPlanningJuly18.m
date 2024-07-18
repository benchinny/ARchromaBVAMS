%%

rgbConditions = [0.555 0.320 1.00; ...
                 0.416 0.320 1.00; ...
                 0.312 0.320 1.00; ...
                 0.555 0.320 0.73; ...
                 0.555 0.320 0.533; ...
                 0.555 0.000 1.00; ...
                 0.416 0.000 1.00; ...
                 0.312 0.000 1.00; ...
                 0.555 0.000 0.73; ...
                 0.555 0.000 0.533; ...
                 ];

wvInFocusST = [612 528 476 612 612 616 472 472 620 620];

wvInFocusXC = [552 532 520 572 584 564 516 496 604 612];

reorderGreen = [5 4 1 2 3];

reorderNoGreen = [10 9 6 7 8];

figure;
set(gcf,'Position',[338 156 1087 788]);
subplot(2,2,1);
plot(1:length(reorderGreen),wvInFocusXC(reorderGreen),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Wavelength in focus');
title('XC with green');
xlim([0.5 5.5]);
ylim([470 630]);
set(gca,'XTickLabel',{});

subplot(2,2,2);
plot(1:length(reorderNoGreen),wvInFocusXC(reorderNoGreen),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Wavelength in focus');
title('XC without green');
xlim([0.5 5.5]);
ylim([470 630]);
set(gca,'XTickLabel',{});

subplot(2,2,3);
plot(1:length(reorderGreen),wvInFocusST(reorderGreen),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Wavelength in focus');
title('Strehl with green');
xlim([0.5 5.5]);
ylim([470 630]);
set(gca,'XTickLabel',{});

subplot(2,2,4);
plot(1:length(reorderNoGreen),wvInFocusST(reorderNoGreen),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Wavelength in focus');
title('Strehl without green');
xlim([0.5 5.5]);
ylim([470 630]);
set(gca,'XTickLabel',{});

figure;
set(gcf,'Position',[338 156 1087 788]);
subplot(2,2,1);
plot(1:length(reorderGreen),humanWaveDefocus(wvInFocusXC(reorderGreen)),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Relative focus (D)');
title('XC with green');
xlim([0.5 5.5]);
ylim([-0.8 0.2]);
set(gca,'XTickLabel',{});

subplot(2,2,2);
plot(1:length(reorderNoGreen),humanWaveDefocus(wvInFocusXC(reorderNoGreen)),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Relative focus (D)');
title('XC without green');
xlim([0.5 5.5]);
ylim([-0.8 0.2]);
set(gca,'XTickLabel',{});

subplot(2,2,3);
plot(1:length(reorderGreen),humanWaveDefocus(wvInFocusST(reorderGreen)),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Relative focus (D)');
title('Strehl with green');
xlim([0.5 5.5]);
ylim([-0.8 0.2]);
set(gca,'XTickLabel',{});

subplot(2,2,4);
plot(1:length(reorderNoGreen),humanWaveDefocus(wvInFocusST(reorderNoGreen)),'ko','MarkerSize',15, ...
     'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Relative focus (D)');
title('Strehl without green');
xlim([0.5 5.5]);
ylim([-0.8 0.2]);
set(gca,'XTickLabel',{});

