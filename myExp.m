function code = myExp
% defaultVirmenCode   Code for the ViRMEn experiment defaultVirmenCode.
%   code = defaultVirmenCode   Returns handles to the functions that ViRMEn
%   executes during engine initialization, runtime and termination.


% Begin header code - DO NOT EDIT
code.initialization = @initializationCodeFun;
code.runtime = @runtimeCodeFun;
% End header code - DO NOT EDIT
code.termination = @terminationCodeFun;

tic
end


% --- INITIALIZATION code: executes before the ViRMEn engine starts.
function vr = initializationCodeFun(vr)
    
    global dataFromDAQ;
    global sounds;
    global shiftCounter;
    global timeUntilCoolOffRoom;
    timeUntilCoolOffRoom = 0;
    shiftCounter = 0;
    sounds = double.empty;
    vr = playerInit(vr,1500);
    vr.counter = 0;
    vr.soundProfile = 0;
    vr = miniGUI(vr);
    vr.currentWorld = 1;
    vr.t1 = 0;
    vr.t2 = 0;
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
    addAnalogInputChannel(vr.ai,'Dev1',[8,9],'Voltage');

    % define the sampling rate to 1kHz and set the duration to be unlimited
    set(vr.ai,'Rate',20000,'DurationInSeconds',1)
    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    set(vr.ai,'NotifyWhenDataAvailableExceeds',500);
    vr.timeOfSample = vr.ai.Rate./vr.ai.NotifyWhenDataAvailableExceeds;
    vr.timePerSample = vr.ai.NotifyWhenDataAvailableExceeds./vr.ai.Rate;
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
    vr.fid1 = fopen('virmenLog.dat','w');
    vr.fid2 = fopen('A-B_record.dat','w');

    vr.ai.IsContinuous = true;
    startBackground(vr.ai);



end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    global dataFromDAQ;
    global timeUntilCoolOffRoom;
    
    %sound
    switch vr.soundProfile
        case 1
           soundInRangeA(vr, 30);
        case 2
            soundTestgpt(vr, 1500)
            %soundEqualB(vr, 30,1000);
            %soundEqualB(vr, 230,500);
        case 3
            soundDiffC(vr, 230,500);
        otherwise
            disp('ERROR myExp')
    end
    
    %log data
    % obtain the current timestamp
    %timestamp = clock;
    % write timestamp and the x & y components of position and velocity to a file
    % using floating-point precision
    
    
    %fwrite(vr.fid1, [timestamp(6) vr.velocity(2)],'double');
    
    
    %t = linspace(double(0), double(vr.timePerSample), vr.ai.NotifyWhenDataAvailableExceeds);
    %r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    %dataFromDAQAEven = dataFromDAQ(:,1);
    %dataFromDAQBEven = dataFromDAQ(:,2);
    %matrix = [r1+250*vr.counter ;dataFromDAQAEven(2:2:end).';dataFromDAQBEven(2:2:end).'] ;
    %fwrite(vr.fid2, matrix,'double');
    %vr.counter = vr.counter + 1;
    
    %checking position for reward
    function coolOfRoom(~,~)
        timeUntilCoolOffRoom = 1;
    end
    function backToStart(~,~)
        timeUntilCoolOffRoom = 2;
    end

    % Create the timer object
    % Start the timer object
    if (vr.position(2)>=125)

        if (vr.t1 == 0)
            %vr.worlds{vr.currentWorld}.surface.visible(:) = false;
            vr.t1 = timer('TimerFcn', @coolOfRoom, 'ExecutionMode', 'singleShot', 'StartDelay', 2);
            vr.t2 = timer('TimerFcn', @backToStart, 'ExecutionMode', 'singleShot', 'StartDelay', 2);
            
            start(vr.t1);
        end
        %check if the time to switch rooms has arrived
        if (timeUntilCoolOffRoom ~= 0)
            %check which room
            if (timeUntilCoolOffRoom == 1)
                vr.currentWorld = 2;
                start(vr.t2);
            else
                %go back to init position
                vr.currentWorld = 1;
                vr.position(2) = -100;
                %reset timers
                vr.t1 = 0;
                vr.t2 = 0;
            end
            timeUntilCoolOffRoom = 0;

            
            %vr.currentWorld = mod(vr.currentWorld,2)+1;
            %vr.position(2) = 0;
        end
    end
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    % stop the analog input object
    delete(vr.t1);
    delete(vr.t2);    
    stop(vr.ai);
    % close the file
    fclose(vr.fid1);
    fclose(vr.fid2);
    %logData();
    % delete the temporary log file
%     delete(vr.tempfile);
end
