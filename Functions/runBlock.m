function blockData = runBlock(b, tDesign)

    global visual design
    
    % print some messages at the beginning
    messageStart = sprintf('This is block no. %i', b);
    DrawFormattedText(visual.window, messageStart, 'center', 200, visual.textColor);
    DrawFormattedText(visual.window, 'Press any key to start', 'center', 'center', visual.textColor);
    Screen('Flip',visual.window);
    
    KbPressWait;  

    t = 1;
    
    % go through trials
    while t <=  design.nTrialsPB
            
        trial = tDesign.trial(t);
        blockData.trial(t) = runSingleTrial(trial);
        t = t+1;                   
    
    end

    Screen('Flip', visual.window);
    WaitSecs(2);
end
