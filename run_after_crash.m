       %%%%%%%To load temp file and save it into permanent file and to load tca parameters%%%%%%%%% 
       load('TCAtmp.mat'); bxy=xy4; v0=n5; sv=1; sn=20;
        z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
        z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
        if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
        clear bxy v0