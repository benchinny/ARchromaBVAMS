addpath([pwd '\JnJ']); addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); addpath([pwd '\data\System TCA\Data Processing']);  addpath(genpath(fullfile('toolboxes')));
%KbWait([], 2); 
%combine fgr_TCA and fgr_CSF 
%combine JJVC_STRT, JJVC_MDFY & CHNG_ACL
%check frngE!!!
%original purple cf               cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; n0=4; cg='p';  %gamma corrected/purple background
%updated to new one on 210621 affecting the right screen
%GAMMA CORRECTION PARAMETERS IN START/MODIFY
%DASHED LINE FOR ACL0 csf FIT
%darker color and circle marker for previous data

imcal has uint8 in it! do all calcs before in double!!!
fgr_TCA line 131
psf_CSF0
%LCAp TCAp ETMp save parameters
%optotype focus task function
%add errorbars to contrast sensittivity plot and add multiple datas
%print foreign income statement on BVAMS computer!
%CHNG_ACL
%Send austin today's data
%focus task before fringe
%control optotype size in ETM focus
%add blamk after button press in CSF
%optotype reduce file size by a factor of 4
%green in ACL0 vs ACL1 condition check effect
%top vs bottom chromostereopsis results.
%calc marty CSF!!!
%change focus independently in ETM task
% generate VA plot bars
%palamedes, send email weichman to marty
%get one more subject so that I could learn how to run him, avoid dilation
%save stroke size with ETM file
%knobs for binocular adjustment
%move back to one side moving during LCA task
%save tombone and focus power when doing TCA
%AJR compare April 30 fringe data with newer data

%look into original/TCA files!

%AJR MAY21 updated fringe experiment CRM&CSF
%MSB ACL0May20 ACL1May24 updated fringe experiment CRM&CSF

%combine all TCA data? pupil alignment alters TCA data. Recently,
%1binocular alignment --> more accurate TCA.
%look into CSF 2down1up!!!!
%monocular TCA -> CSF &ETM.  

%ETM save final focus values 
%May 20 Marty ACL0 is good data green looked sharper.
%MAY24 MSB ACL1
%AJR May30 is questionable
%TCA experiment save trombone and focus positions
%change yx in TCA convention for easier comprehension 
%We have to get data from me this week! 
%figure which screen is moving right for chromostereopsis
%recheck fringe! why conditions 5 through 8 are not detected
%

%better data management system swati prefers folder system code to put files into folders based on name
%do chromostereopsis after binocular alignment task before ETM
%psignfit pin top level to 100% for marty, stroke width on abscissa in minutes of arc
%end experiment with black screen!
%for thursday: show frng options, Swati leaving....

%scrpts I wrote and their dscription
%220304 PPR_LCA 

%220227 psf_CNT0 psignfit for constant chromostereopsis based on psf_CNT

%220105 JnJ_LCA JnJ_TCA LCA16f TCA16f use vs for visit number!
%211223 JnJ_NLZ psfe3 hst2 analysze
%211213 ETM17f move back to binocular for JJVC subjects
%211206 CVO21_TCA based on fgr_TCA_CSF
%211202 findPupilCenter right ACL0
%211119 findPupilCenter right ACL0
%211119 AFC4f binocular
%211117 JnJ211117 cmbn1 psf_ETM5 VA data for JnJ
%211109 JJVC AFC AFC1f use JJVC randomization
%%211102 DSP_IMG
%%211027 fgr_CRM including top/bottom responses
%211025 fgr_CRM including red/blue bottom option
%211021 JJVC_AFC AFC0f autorefractor code 
%211014 JJVC_ARFC autorefractor accomodation experiment
%211013 fgr_ETM including fitglme
%211012 JJVCglme check balanced designs (white&purple) for figlme ANOVA
%211008 findPupilCenter after autorefractor-mirrorglass integration
%210918 fgr_TCA_CSF data for Marty 
%210908 LgnRtcl210908 code to align reticle based on 210604 JJVC_LCA run LCA task
%210906 fgr_ETM psf_ETM4 for LOGSCALE ANOVA
%210903 findPupilCenter updated 
%210818 fgr_CRM chromostereopsis using Austinn method
%210818 tst0 findPupilCenter
%210817 tst0 SysTca210817 Ltca_noACL Rtca_noACL Rtca_ACL Ltca_ACL
%210812 kbLCA3 kbLCA4 for SysTCA otherwise use kbLCA2 (no trombone power adjustment, only magnification)
%210722 fgr_TCA_CSF manage TCA and CSF in the same script
%210713 JJVC_SMC JJVC START MODIFY CHNG ACL combined
%210712 ETM17f moving to a bigger optotype set. orientation on the fly.
%210707 ETM16f corrected glitch in TCA0 calculation 
%210707 fgr_ETM psf_ETM3 incorporate ANOVA analysis
%210706 autorfctr operate labview alignment and autorefractor
%210705 fgr_ETM psf_ETM2 psfe2 calculate arrorbars using mean and std
%210702 FRNG4f
%210702 cld close figures and psychtoolbox
%210702 fcs_clr in ETM12f & CSF6f focus green color before task 
%210701 fcs_opt FRNG16f FRNG4f focus optotype/optotune before experiment 
%210701 FRNG3f move to next trial upon keypress
%210628 fgr_ETM psf_ETM1 psfe1 use log10 to calc threshold & CIs
%210624 psf_CSF1 use log10 to calculate correct CI90 parameters
%210624 psignfit for contrast sensitivity using log10 to correct for many low points
%210624 psf_ETM0 cmbn0 psfe0 take in data with different optotype sets
%210622 ETM15f & JJVC_ETM switched to monocular and only load TCA file 
%210621 JJVC_ETM corrected purple background and added no TCA offset for green background 
%210621 cwin3 added output image to temp file save
%210621 FRNG2f added up&down direction to the fringed E
%210620 ETM14f trying to improve TCA implementation
%210618 ETM13f added optotype size control in focus adjustment
%210617 ETM12f added contrast cntrst contrast control
%210617 JJVC_frngE FRNG1f optotype fringe task
%210615 added z0, z1. z2, to JJVC_TCA through VRMCp
%210614 fit_CSF0 fixed frequency
%210613 fgr_TCC combine TCA CSF CNT
%210613 fit_CSF
%210613 psf_CNT outputting CI95
%210613 combined TCA CSF & CRM plot!
%210610 first significant result, first time anyone as shown improved acuity with correcting chromatic abberation specifically in purple background.
%210610 screen centering & FOV measurement =800pixels = 3degrees, rc00=[4 -7; 8 -6]; 
%210608 TCA11f control optotype size in focus task
%210608 E_b2s5_p10_p22_o4_ms10_210608 optotype series for jim larimer JOL
%210608 LCA12f & ETM12f finalized independent control of trombone&focus
%210604 JJVC_ETM JJVC_CSF JJVC_CNT
%210604 JJVC_TCA VRCMprm save varichrome parameters into struct
%210604 JJVC_LCA LCA12f make sure colors don't appear consecutively.
%210604 kbLCA2 in LCA11f control right or left side.
%210604 JJVC_STRT
%210525cmbn combine ETM data
%210523 fgr_ETM calculate data/figure for ETM/VA data
%210521 psfa2 
%210520 psfs chaned xlabel to phase shift
%210519 TCA11f added independent binocular focus
%210519 LCA11f line43 make sure LCA task starts with blue stimuli
%210518 psfa1 pin fit to 100% and use Snellen in abscissa 
%210517 fnz0 find z0 based on trombone power
%210517 JJVC_FRNG & FRNG0f script and function to run fringe experiment
%210513 frngs3 present specific conditions
%210512 frngs2 uses pregenerated images
%210512 gen_frngs generate stimuli for fringe experiment 
%210511 TCA10f added green E for focus before the task begins
%210510 CSF5f added randomization and put into JJVC_mono0!!!
%210510 finished CSF4f, still not happy about the colors
%210505 JJVC_xport prepare data for derek
%210504 CSF4f & gbr0 need to finish CSF4f!!!
%210503 show_TCA showETM show_FRNGS show_CSF
%210503 align_sub0 & ETM12f control focus before ETM task
%210429 JJVC_mono0 & LCA11f trying to keep to varichrome running in global
%mode
%210429 mrg & mrg0 merge top/bottom, left/right of two images
%210429 frngs1  half screen with gray gap fringed and no fringed together
%210428 OPNT open optotune and trombone function
%210419 expedite frngs0
%210416 frngs changed to half screen stimuli
%210415 equalized luminance on right display
%210414 equalized luminance on left display
%210412 combine LCA adjustment into ETM12f
%210408 CSF3f took out the pause between trials per Austin's request.
%210331 frngs added a blue circle for pupil alignment purposes
%210330 cmb0 combine left and right TCA and LCA values
%210326 frngs added second/system tca 
%210316 sqrs0 fixed the issue with the d in b.^(n/d)
%210306 LCA10f-kbLCA1 added Return to escape key
%210305 CNT1f added blue reticle to fixation stim
%210304 TCA10f include Return to move to next trial, JJVC_mono added,
%labview propmpt, LCA10f disable up/down arrows, gen_TCA reduced cneter
%circle diameter to 65 pixels 
%210303 TCA10f add blue reticle only when green circle shows up.
%210302 TCA9f, gen_TCA, c130_b145to540_r340to350_w10_ms10_sd1_6 add a blue ring
%210224 bnd set bounds for a variable TCA8f including condition to start with blue circle 
%210223 changed LCA9f to not inclue random initial positions
%210222 opt00 output powerL powerR/ picked up visa/ JJVC_mono/ LCA9f
%received my J1 visa to the states exciting day
%210205 calculate Qazrin loan repayment
%210201 ETM11f including system TCA
%210131 TCA7 showing both stimuli on both displays
%210118 CRM3f chromostereopsis with fixed conditions
%210105 gmc0 increment luminance for gamma correction
%210105 CSF1f add nogo to next trial unless left/right arrowkey
%210104 CRM2f chromostereopsis with fixed conditions
%201230 CSF0f contrast sensitivity function based on gbr4/5
%201229 gbr5 gbr4 with red-blue shift
%201223 tst0 generate RGB squares
%201223 tst0 surf matrix for marty 
%201222 tst0 luminance-pixel values for equiluminance
%201219 psfc psignfit for contrast sensitivity
%201217 gbr4 present contrast sensitivity with pixel shifts
%201217 showpt show optotype with TCA0 and TCA1
%generateoptotype 
%psfc psignfit for chromostereopsis
