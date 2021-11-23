function genDesign(vpcode)
% eye movements only
% 2017 by Martin Rolfs
% 2021 mod by Clara Kuper

global design visual

% set values that generalize across both parts
% randomize random
rand('state',sum(100*clock));

% general experiment info
design.vpcode    = vpcode;

% timing
design.iti       = 0.2; % Inter trial interval
design.waitToFix = 2.0;

% stimulus design specifics
design.tarRad = 1; % diameter of target in dva

% conditions
design.TargetxPos = [-5,5]; % left and right target presentation
design.TargetyPos = [-5,5]; % the target can be shifted inwards ot outwards

design.nBlocks = 2;
design.nTrials = 1;

    
for b = 1:design.nBlocks
    t = 0;
    for tr = design.nTrials
        for xPos = design.TargetxPos
            for yPos = design.TargetyPos
                t = t+1;
                % define the trial condition
                trial(t).targetPosition = [xPos*visual.ppd, yPos*visual.ppd] + [visual.xCenter, visual.yCenter]; % the position of the target (in pixel)   

            end
        end
    end
    
    % randomize trials
    r = randperm(t);
    block(b).trial = trial(r);
    clear trial;
end

br = randperm(b);
design.block = block(br);
design.nTrialsPB  = t;

% save 
save(sprintf('./Design/%s.mat',vpcode),'design');

end

