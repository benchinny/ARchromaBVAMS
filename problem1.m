    
d1= [7     3    11;
     8    21    28;
     9    16    17;
    10     7     9;
    11     5     5];

d2= [7     0     4;
     8    12    21;
     9    20    25;
    10    14    14;
    11     3     4;
    12     2     2]

options = struct;
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
%options.expType     = '4AFC';   % choose 2-AFC as the paradigm of the experiment
options.expType        = 'nAFC';
options.expN           = 4;

options.threshPC       = 0.781; %threshold
 options.betaPrior=1

    options.borders=[0 40; %6 32; %8.7927   25.9276;
                    0   31.0570; %2.0771   31.0570;
                    0    0; %0.5000; a fixed lapse rate of .05
                    0.2500    0.2500;
                    0    1]; %0.7368];
                
                
                
                   result = psignifit(d1,options);
                   figure; plotPsych(result);