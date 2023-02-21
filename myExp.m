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
    
    vr = playerInit(vr,1500);
    
    vr.soundProfile = 0;
    vr = miniGUI(vr);
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
    addAnalogInputChannel(vr.ai,'Dev1',[8,9],'Voltage');

    % define the sampling rate to 1kHz and set the duration to be unlimited
    set(vr.ai,'Rate',9600,'DurationInSeconds',1)
    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    set(vr.ai,'NotifyWhenDataAvailableExceeds',100);
    vr.timeOfSample = vr.ai.Rate./vr.ai.NotifyWhenDataAvailableExceeds;
    %radius of 9.525 cm for the wheel.
    vr.lh = addlistener(vr.ai,'DataAvailable',@getData);
    function getData(src,event)
         dataFromDAQ = event.Data;
    end
    % define a temporary log file to be deleted at the end of the experiment
    %set(vr.ai,'loggingmode','Disk');
    %vr.numberOfTrials = 0;
    %vr.currRoundNum = 0;
    %tempname = today('datetime')
    %vr.tempfile = [tempname '.log'];
    %sset(vr.ai,'logfilename',vr.tempfile);
    % start acquisition from the analog input object
    
    % open or create binary file for writing and store its file ID in vr
    vr.fid = fopen('virmenLog.dat','w');
    
    vr.ai.IsContinuous = true;
    startBackground(vr.ai);



end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    switch vr.soundProfile
        case 1
           soundInRangeA(vr, 30);
        case 2
            soundEqualB(vr, 30,1000);
        case 3
            soundDiffC(vr, 30);
        otherwise
            disp('ERROR myExp')
    end
    
    % obtain the current timestamp
    timestamp = clock;
    % write timestamp and the x & y components of position and velocity to a file
    % using floating-point precision
    fwrite(vr.fid, [timestamp(6) vr.velocity(2)],'double');

end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    % stop the analog input object
    
    stop(vr.ai);
    % close the file
    fclose(vr.fid);

    % delete the temporary log file
%     delete(vr.tempfile);
end
