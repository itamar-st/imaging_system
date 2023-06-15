function code = myExp
% defaultVirmenCode   Code for the ViRMEn experiment defaultVirmenCode.
%   code = defaultVirmenCode   Returns handles to the functions that ViRMEn
%   executes during engine initialization, runtime and termination.


% Begin header code - DO NOT EDIT
code.initialization = @initializationCodeFun;
code.runtime = @runtimeCodeFun;
code.termination = @terminationCodeFun;
% End header code - DO NOT EDIT

end


% --- INITIALIZATION code: executes before the ViRMEn engine starts.
function vr = initializationCodeFun(vr)
    
    global timeUntilCoolOffRoom;
    
    %vr.trackLength = eval(vr.exper.variables.trackLength)
%     vr.exper.variables.x = '200';
    timeUntilCoolOffRoom = 0;
    vr.counter = 0;
    
    vr.timeOfRanningInRange = 0;
    vr.timeOfTotalRun = 0;
    %counting amount of finished trials in a session.
    vr.countTrials = 0;
    vr.endOftheRoad = 220;
    vr.isRewardGiven = 0;
    vr = createLogFiles(vr); % for logging all files
    vr = miniGUI(vr); % show the GUI for chosing the experiment preferences
    
    %choose world, return line 27 if you want to control it via GUI and
    %comment lines 29-34
    %vr.currentWorld = vr.chosenWorld; %show the world we chose in the GUI
    randomNumber = rand;
    if (randomNumber > 0.5)
        vr.currentWorld = 1;
    else
        vr.currentWorld = 3;
    end
    
    vr = timerInit(vr); % start the timers for changing rooms
    
    vr = DAQInit(vr); % data acquisition system
end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    
    %choose the sound policy
    switch vr.soundProfile
        case 1
            vr = soundInRangeA(vr, vr.targetSpeed, vr.allowedDeviation,1600);
        case 2
            vr = soundEqualB(vr, vr.targetSpeed, vr.allowedDeviation, vr.DeviationBetweenSteps, 1000);
        case 3
            vr = soundDiffC(vr, vr.targetSpeed, vr.allowedDeviation,vr.DeviationBetweenSteps,2000);
        otherwise
            disp('ERROR selecting sound profile')
    end
    
    % count how much time it was on the target speed
    if((vr.targetSpeed  <= vr.velocity(2) + vr.allowedDeviation) && ...
            (vr.targetSpeed  >= vr.velocity(2) - vr.allowedDeviation))
        vr.timeOfRanningInRange = vr.timeOfRanningInRange+vr.ai.NotifyWhenDataAvailableExceeds;
    end
    
    %checking position for reward
    if (vr.position(2)>=vr.endOftheRoad)
        vr = endOfTraceProcedure(vr);
    else
        % count the time on trace before reaching to the end
        vr.timeOfTotalRun = vr.timeOfTotalRun + vr.ai.NotifyWhenDataAvailableExceeds;
    end
    
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    vr = freeAlocations(vr);
    vr = stopSound(vr);
    vr = plotData(vr);
end
