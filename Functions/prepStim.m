% prepare stimuli for presentation

function prepStim
  global visual design

  
  % define stimulus properties as visuals
  % parameters for stimuli in pix
  % parameters that differ on a trial-by-trial basis are set on each trial
  visual.bgColor = visual.white * [0.5, 0.5, 0.5];
  visual.targetRadius   = design.tarRad * visual.ppd; % the size of the taret in pixel
  visual.targetColor    = visual.white; % the color of the target
  visual.textColor    = visual.white; % the color of the text
  
end
