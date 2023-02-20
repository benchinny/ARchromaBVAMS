% Meta-test that runs all other tests, as a noninteractive batch for CI. 
% This file is the CI test entry point for old versions of MATLAB that do 
% not have the -batch command line optin.
try
    TestAll;
catch e
    disp(getReport(e));
    exit(1);
end
exit(0);
