clear all
close all
clc
fig = uifigure('Position',[680 678 398 271]);
bg = uibuttongroup(fig,'Position',[137 113 123 113]);  

rb0 = uiradiobutton(bg,'Position',[10 82 91 15]);
rb1 = uiradiobutton(bg,'Position',[10 60 91 15]);
rb2 = uiradiobutton(bg,'Position',[10 38 91 15]);
rb3 = uiradiobutton(bg,'Position',[10 16 91 15]);

rb0.Text = 'Hebrew';
rb1.Text = 'English';
rb2.Text = 'French';
rb3.Text = 'German';

%uipanel