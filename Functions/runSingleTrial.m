function trialData  = runSingleTrial(trial)
    
    global design visual
    
    % turn off responses
    ListenChar(0);
    t_init = GetSecs();
    
    % prepare the trial
    % set stimuli
    tarPos = trial.targetPosition;
    tarRad = visual.targetRadius;
    tarCol = visual.targetColor;

    % initialize & reset timing variable 
    t_start    = NaN;  % the trial has started
    t_draw     = NaN;  % the first stimulus was on screen
    t_mousepress = NaN;  % the mouse was pressed
    t_feedback = NaN;  % feedback was on screen
    t_end      = NaN;  % the trial is over
    rea_time   = NaN;  % the reaction time

    % positions
    resp_X     = NaN;  % response mouse x
    resp_Y     = NaN;  % response mouse Y
    
    % per default, the trial is a success :)
    trial_succ = 1;
    
    % Run the trial. get a time stamp here
    t_start = GetSecs(); 
	
    % Display the dots and flip them on screen
    Screen('DrawDots', visual.window, tarPos, tarRad, tarCol, [], 2); % draw target
    [~, t_draw, ~] = Screen('Flip', visual.window);
 
    % check if the mouse was clicked 
    [~,~,buttons,~,~,~] = GetMouse(visual.window);
    
    while ~ any(buttons)
        % continue checking till the mouse was clicked
        [resp_X,resp_Y,buttons,~,~,~] = GetMouse(visual.window);
    end
    
    % as soon as this loop ends, get a time stamp for the mouse click
    t_mousepress = GetSecs();
    rea_time = t_mousepress - t_draw;
        
    t_end = GetSecs();
    
    % present feedback
    rt_message = sprintf('Reaction Time: %.3f seconds at %.0f x and %.0f y', rea_time, resp_X, resp_Y);
    DrawFormattedText(visual.window,  rt_message, 'center', 'center', visual.textColor);
    trial_succ = 1;
    
    Screen('Flip', visual.window);
    t_feedback = GetSecs();
    WaitSecs(1.5);

    trialData.success         = trial_succ;                                 % 1 = success
    trialData.rea_time        = rea_time;
    trialData.t_init          = t_init;
    trialData.t_start         = t_start;
    trialData.t_draw          = t_draw;
    trialData.t_mousepress    = t_mousepress;
    trialData.t_end           = t_end;
    trialData.t_feedback      = t_feedback;
    
    trialData.clickX          = resp_X;
    trialData.clickY          = resp_Y;

    WaitSecs(design.iti);
end