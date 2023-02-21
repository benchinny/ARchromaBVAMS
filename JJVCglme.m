%% 3way ANOVA for unbalanced design color: r g b
%hg=[mL0T0g';  mL1T0g'; mL0T0p'; mL1T0p'; mL0T1p'; mL1T1p'; mL0T0w';  mL1T0w'; mL0T1w'; mL1T1w']
hg=[mL0T0p'; mL1T0p'; mL0T1p'; mL1T1p'; mL0T0w';  mL1T0w'; mL0T1w'; mL1T1w']

% ACL=[repmat('A0', [length(mL0T0g) 1]); repmat('A1', [length( mL1T0g) 1]);...
ACL=[repmat('A0', [length(mL0T0p) 1]); repmat('A1', [length( mL1T0p) 1]);...
     repmat('A0', [length(mL0T1p) 1]); repmat('A1', [length( mL1T1p) 1]);...
     repmat('A0', [length(mL0T0w) 1]); repmat('A1', [length( mL1T0w) 1]);...
     repmat('A0', [length(mL0T1w) 1]); repmat('A1', [length( mL1T1w) 1]);...
     ];
 
%  TCA=[repmat('T0', [length(mL0T0g) 1]); repmat('T0', [length( mL1T0g) 1]);...
 TCA=[repmat('T0', [length(mL0T0p) 1]); repmat('T0', [length( mL1T0p) 1]);...
      repmat('T1', [length(mL0T1p) 1]); repmat('T1', [length( mL1T1p) 1]);...
      repmat('T0', [length(mL0T0w) 1]); repmat('T0', [length( mL1T0w) 1]);...
      repmat('T1', [length(mL0T1w) 1]); repmat('T1', [length( mL1T1w) 1]);...
     ];
 
 %CLR=[repmat('G', [length(mL0T0g) 1]); repmat('G', [length( mL1T0g) 1]);...
 CLR=[repmat('P', [length(mL0T0p) 1]); repmat('P', [length( mL1T0p) 1]);...
      repmat('P', [length(mL0T1p) 1]); repmat('P', [length( mL1T1p) 1]);...
      repmat('W', [length(mL0T0w) 1]); repmat('W', [length( mL1T0w) 1]);...
      repmat('W', [length(mL0T1w) 1]); repmat('W', [length( mL1T1w) 1]);...
     ];
dat
results = multcompare(stats,'Dimension',[1 2 3])


%generelized linear model main factors
t=table(ACL, TCA, CLR, hg,...
    'VariableNames', {'ACL', 'TCA', 'CLR', 'VA'})
t.ACL = categorical(cellstr(t.ACL));
t.CLR = categorical(cellstr(t.CLR));
t.TCA = categorical(cellstr(t.TCA));
mdl = fitlm(t)

%anova(mdl,'summary')

plot(mdl)


%generelized linear mixed-effects model main factors
glme0 = fitglme(t,'VA ~ ACL + TCA + CLR', 'Distribution','Normal','Link','identity', 'FitMethod','rempl')


%anovan main factors with type 2 sum squares main factors
[p,tbl,stats] = anovan(hg,{ACL TCA CLR},'varnames',{'ACL','TCA', 'CLR'}, 'sstype', 2) 


%anovan main factors with type 2 sum squares interactions
[p,tbl,stats] = anovan(hg,{ACL TCA CLR},'varnames',{'ACL','TCA', 'CLR'}, 'sstype', 2, 'model', 'interaction') 


%anovan main factors with type 1 sum squares interactions
[p,tbl,stats] = anovan(hg,{ACL TCA CLR},'varnames',{'ACL','TCA', 'CLR'}, 'sstype', 1, 'model', 'interaction') 



%generelized linear mixed-effects model with interactions
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','rempl')

glme0 = fitglme(t,'VA ~ ACL + TCA + CLR + ACL:TCA + ACL:CLR + TCA:CLR',...
'Distribution','Normal','Link','identity', 'FitMethod','rempl')

anova(glme0,'dfmethod','residual')

anova(glme0,'dfmethod','none')

glme1 = fitlme(t,'VA ~ ACL + TCA + CLR + ACL:TCA + ACL:CLR + TCA:CLR',...
'FitMethod','ml') %''reml')

anova(glme1,'dfmethod','satterthwaite')

anova(glme1,'dfmethod','residual')

anova(glme1,'dfmethod','none')



B = fixedEffects(glme0)

%'Distribution','Normal','Link','identity','FitMethod','Laplace')

'Distribution','Normal','Link','log','FitMethod','Laplace','DummyVarCoding','effects')

glme2 = fitglme(tbl,'VA ~ CLR*ACL + CLR*TCA + ACL*TCA + CLR + ACL + TCA',...
'Distribution','Normal','Link','identity')

lm0 = fitlm(t,'VA ~ ACL + TCA + CLR + ACL:TCA + ACL:CLR + TCA:CLR')
,...
'FitMethod','ml') %''reml')

glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity')
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','MPL')
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','Laplace')
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','REMPL')
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','ApproximateLaplace')


%a step in the right direction slide13
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'DummyVarCoding','effects')

glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'DummyVarCoding','reference')
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'DummyVarCoding','full')

%% The right setting!
glme1 = fitglme(t,'VA ~ ACL*TCA + TCA*CLR + CLR*ACL', 'Distribution','Normal','Link','identity', 'FitMethod','REMPL', 'DummyVarCoding','effects')



