function psych0(n)

% Here we call some default settings for setting up Psychtoolbox
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
PsychDefaultSetup(n);