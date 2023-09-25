%%

imR = AFCwordStim('car',[500 500],[70 70; 160 70; 260 70],'red',200);
imR(imR>0) = 255;
figure; imagesc(imR./255);set(gca,'XTick',[]); set(gca,'YTick',[]); clim([0 1]);
imB = AFCwordStim('car',[500 500],[70 70; 160 70; 260 70],'blue',200);
imB(imB>0) = 255;
% figure; imagesc(imB./255); set(gca,'XTick',[]); set(gca,'YTick',[]); clim([0 1]);

[xx, yy] = meshgrid(-1:0.075:1,-1:0.075:1);
blurKernel = mvnpdf([xx(:) yy(:)],[0 0],[0.5 0; 0 0.5]);
blurKernel = blurKernel./sum(blurKernel(:));
blurKernel = reshape(blurKernel,size(xx));
imBlurB = conv2(squeeze(imB(:,:,3)),blurKernel);
imBlurB = imBlurB(14:513,14:513);
imBlur(:,:,1) = zeros(size(imBlurB));
imBlur(:,:,2) = zeros(size(imBlurB));
imBlur(:,:,3) = imBlurB;

blurKernel2 = mvnpdf([xx(:) yy(:)],[0 0],[0.05 0; 0 0.05]);
blurKernel2 = blurKernel2./sum(blurKernel2(:));
blurKernel2 = reshape(blurKernel2,size(xx));
imBlurB2 = conv2(squeeze(imB(:,:,3)),blurKernel2);
imBlurB2 = imBlurB2(14:513,14:513);
imBlur2(:,:,1) = zeros(size(imBlurB2));
imBlur2(:,:,2) = zeros(size(imBlurB2));
imBlur2(:,:,3) = imBlurB2;

imG = zeros(size(imBlur));
imG(:,:,2) = imBlur2(:,:,3);

figure; imagesc(imBlur./160); set(gca,'XTick',[]); set(gca,'YTick',[]); clim([0 1]);

figure; imagesc((1*imBlur+imR.*1+imG)./160); set(gca,'XTick',[]); set(gca,'YTick',[]); clim([0 1]);

%%

x = 0:0.01:6.5;
y = imresize([3 4],[1 length(x)],'nearest');
figure;
set(gcf,'Position',[387 486 1103 420]);
subplot(1,2,1);
hold on;
plot(x(1:round(length(x)/2)),y(1:round(length(x)/2)),'-','LineWidth',2,'Color',[0.62 0 0]);
plot(x((round(length(x)/2)+1):end),y((round(length(x)/2)+1):end),'-','LineWidth',2,'Color',[0.62 0 1]);
xlim([0 6.5]);
ylim([0 5]);
set(gca,'FontSize',20);
xlabel('Time(s)'); 
ylabel('Accommodative demand (D)');
y = imresize([3 2],[1 length(x)],'nearest');
subplot(1,2,2);
hold on;
plot(x(1:round(length(x)/2)),y(1:round(length(x)/2)),'-','LineWidth',2,'Color',[0.62 0 0]);
plot(x((round(length(x)/2)+1):end),y((round(length(x)/2)+1):end),'-','LineWidth',2,'Color',[0.62 0 1]);
xlim([0 6.5]);
ylim([0 5]);
set(gca,'FontSize',20);

