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
    
    global dataFromDAQ;
    global timeUntilCoolOffRoom;
    
    %vr.trackLength = eval(vr.exper.variables.trackLength)
    vr.exper.variables.x = '200';
    timeUntilCoolOffRoom = 0;
    vr.counter = 0;
    vr.timeOfRanningInRange = 0;
    vr.timeOfTotalRun = 0;
    vr.precentageOfRunningInRange = 0.7;
    vr = miniGUI(vr); % show the GUI for chosing the experiment preferences 
    vr.currentWorld = vr.chosenWorld; %show the world we chose in the GUI
    
    vr = timerInit(vr); % start the timers for changing rooms
    
    vr = createLogFiles(vr); % for logging the A-B voltage an velocity

    vr = DAQInit(vr); % data acquisition system
end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    
    %choose the sound policy
    switch vr.soundProfile
        case 1
            vr = soundInRangeA(vr, vr.targetSpeed, vr.allowedDeviation,1600);
        case 2
            vr = soundEqualB(vr, vr.targetSpeed, vr.allowedDeviation,1000);
        case 3
            vr = soundDiffC(vr, vr.targetSpeed, vr.allowedDeviation,2000);
        otherwise
            disp('ERROR myExp')
    end
    
    %checking position for reward
    if (vr.position(2)>=125)
        vr = endOfTraceProcedure(vr);
    end
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    vr = freeAlocations(vr);
    vr = stopSound(vr);
    vr = plotData(vr);
end
