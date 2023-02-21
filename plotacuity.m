f1=figure(1);
clf();
hold on;
x=1:320;
% lets say the condition is now a flag containing either 1 or 0, I assume
% it's more complex in your case, but for simplicity's sake lets keep it
% like that: 1=random, 0=sequenced
SRTT.Sequence = [ones(160,1); zeros(160,1)];
SRTT.RT = [rand(1, 160) * 80, 161:320]';
% create masks according to trial condition
randFlags = SRTT.Sequence == 1;
seqFlags = SRTT.Sequence == 0;
y=SRTT.RT(1:320);
plot(x(randFlags),y(randFlags),'-o', 'Color', 'b');
plot(x(seqFlags),y(seqFlags),'-o', 'Color', 'r');
ylabel('Reaction Time (s)');
xlabel('Trial');
set(gca, 'fontsize' , 16, 'fontweight', 'bold');
set(gca,'XTick',(0:20:320));