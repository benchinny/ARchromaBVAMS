clr
addpath([pwd '\fcns']); addpath([pwd '\imgs'])



load('E_b2_m16top15.mat');

%i4=usz(i3, ms); % i4=imgaussfilt(i4,3); 
ms=10;
E10c=cell(16, 4, ms, ms);
tic
parfor k0=7:22;    
    for k1=1:4;
        i4=usz(double(Ec{k0, k1}), ms); % i4=imgaussfilt(i4,3);
        for r0=1:ms
            for c0=1:ms
                %i5=circshift(i4, [r0-1, c0-1]);
                i6=dsz(circshift(i4, [r0-1, c0-1]), ms); 
                %i6=uint8(255.*i6./mxa(i6));
%                 E10c(k0, k1, r0, c0)= {sparse(double(i6))};
                E10c(k0, k1, r0, c0)= {uint8(255.*i6./mxa(i6))};

                disp([k0 k1 r0 c0 ]);
            end
        end
    end
end
toc
save('E_b2_m10_p15_ms10', 'E10c', '-v7.3');
