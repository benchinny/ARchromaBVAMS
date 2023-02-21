function TCAnlz

sn=input('Subject Number? '); sn=sn+1000;
vs=input('Visit Number? ')


load TCAflsL; L=TCAfls{sn-1000,vs};
load TCAflsR; R=TCAfls{sn-1000,vs};

c0=0.00384;  c1=1./(c0.*60);

load(L); mrk='<'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);

eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);


load(R); mrk='>'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
hold on
eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);

if diff(xlim)<diff(ylim);
    lm=xlim;
    xlim([lm(1) lm(1)+diff(ylim)]);
elseif diff(ylim)<diff(xlim);
    lm=ylim;
    ylim([lm(1) lm(1)+diff(xlim)]);
end


lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', [L ' ' R])

