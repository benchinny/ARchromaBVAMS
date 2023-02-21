
MSB%% Labview alignment

%%1st set parameters in NI mex
%%2nd run labview
997236.49
%%NI measurement instrumentation
/NI MAX measurement and automation explorer
    My System --> Devices&interfaces
        2X point grey research
             camera attributes
                analog control (conditions)
                    gain auto = off
                        gain (max=29.9)
                Acquisition control 
                    exposure auto=off
                    frame rate auto = off
                    acquisition frame rate=12
                    exposure time=max =83089.1728
                    exposure compensation auto = off
    save
click devices & interfaces to disengage camera
MINIMIZE max/ correction: may have to close max insteat of minimizing it

OPEN Labview
    OPEN EXISTING 
        TwoCam_Updated12May2021.vi (This PC > Documents > Labview Programs)
            Click RUN (white arrow top left)
            2x Enter sub_exp_name --> NHI_LCA
            2x Enter SubName --> NHI
            Right click
                clear ROI to clear marks
            Input Center X&Y using JJVC_MDFY with 
                 mag=1 if starting from LCA (trombone power ~11diopters)
                 otherwise load LCA data and get X&Y using that data
            Make sure to stop camera (red stop sign) and reRUN for changes to take affect (should see reticle move)
            For existing subjects
                Read Left/Right ROI to get ROI points
            For new subjects
                use ctrl++ to mark new ROIs
            Click on Save Left/Right ROI to save marked ROI (make sure yo save right after picking because it will disappear on the next click)
            Click on black arrow (under magnifying glass) to allow ROI points to stay and not disappear on the next click
            Save Left/Right EYE Image allow you to save the image of the eye with the reticles and ROIs
            ADD a circle to the reticle of desired diameter in  the bottom right corner of every eye
                click stop&run for the change to take affect
            When subject comes back, idealy we want the pupil to be fully centered (aligned to one of the circles) and also have pupil reflex land on previous ROI but if one of this does not happen and we are not too far into data collection than center pupil again and mark new ROI for future uses
            But if have already collected significant data than its better to keep the same ROI and accept slight decentration of the pupil
            *prefer to have pupil focused rather than pupil reflex *