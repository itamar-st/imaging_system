function code = myExp
% defaultVirmenCode   Code for the ViRMEn experiment defaultVirmenCode.
%   code = defaultVirmenCode   Returns handles to the functions that ViRMEn
%   executes during engine initialization, runtime and termination.


% Begin header code - DO NOT EDIT
code.initialization = @initializationCodeFun;
code.runtime = @runtimeCodeFun;
% End header code - DO NOT EDIT
code.termination = @terminationCodeFun;
end


% --- INITIALIZATION code: executes before the ViRMEn engine starts.
function vr = initializationCodeFun(vr)
    
    global dataFromDAQ;
    global sounds;
    global shiftCounter;
    global timeUntilCoolOffRoom;
    
    %vr.trackLength = eval(vr.exper.variables.trackLength)
    vr.exper.variables.x = '200';
    timeUntilCoolOffRoom = 0;
    shiftCounter = 0;
    sounds = double.empty;
    vr.checkIfSoundIsPlaying = 0;
    vr.Soundflag = 0;
    vr.switchFreqFlag = 0;
    vr.player=0;
    vr = playerInit(vr,1500);
    vr.counter = 0;
    vr.counter1 = 1;
    vr.soundProfile = 0;
    vr = miniGUI(vr);
    vr.currentWorld = vr.chosenWorld;
    %start timers
    delete(timerfindall)
    function coolOfRoom(val)
        timeUntilCoolOffRoom = val;
    end
    vr.t1 = timer('TimerFcn', @(~,~)coolOfRoom(1), 'ExecutionMode', 'singleShot', 'StartDelay', vr.leakportBreak);
    vr.t2 = timer('TimerFcn', @(~,~)coolOfRoom(2), 'ExecutionMode', 'singleShot', 'StartDelay', vr.blackRoomBreak);
    vr.rate = 20000;
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
    vr.ai.IsContinuous = true;
    
    vr.ao = daq.createSession('ni');
    vr.ao.IsContinuous = true;
    
    addAnalogInputChannel(vr.ai,'Dev1',[8,9,11],'Voltage');
    addAnalogOutputChannel(vr.ao,'Dev1',1,'Voltage');
    % define the sampling rate to 1kHz and set the duration to be unlimited
    vr.ai.Rate = vr.rate;
    vr.ao.Rate = vr.rate;

            
    initialData = zeros(vr.rate,1);
%     initialData = ones(vr.rate / 10,1)*4;
    vr.ao.queueOutputData(initialData);

    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    vr.ai.NotifyWhenDataAvailableExceeds = vr.rate / 100;
    vr.ao.NotifyWhenScansQueuedBelow  = vr.rate/10;

    vr.timeOfSample = vr.ai.Rate./vr.ai.NotifyWhenDataAvailableExceeds;
    vr.timePerSample = vr.ai.NotifyWhenDataAvailableExceeds./vr.ai.Rate;
    %radius of 9.525 cm for the wheel.
    vr.lh1 = addlistener(vr.ai,'DataAvailable',@getData);
%     vr.lh2 = addlistener(vr.ao,'DataRequired',@sendData);
    function getData(src,event)
        dataFromDAQ = [event.Data event.TimeStamps];
    end

    function sendData(src,event)
        zeros_columns = zeros(vr.rate / 10,1);
        src.queueOutputData(zeros_columns);
    end

    % open or create binary file for writing and store its file ID in vr
    timestamp1 = datestr(clock);    
    vr.nameOfLogFileVel = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestamp1+"velocity.dat",":");
    vr.fid1 = fopen(vr.nameOfLogFileVel,'w');
    vr.nameOfLogFileA_B = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestamp1+"A-B_record.dat",":");
    vr.fid2 = fopen(vr.nameOfLogFileA_B,'w');
    
    vr.aaaa =tic;
    vr.aaaaP = 0;
    % start acquisition from the analog input object
    startBackground(vr.ai);
    startBackground(vr.ao);
end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
    global dataFromDAQ;
    global timeUntilCoolOffRoom;

    %test for performence
%        zeros_column = zeros(vr.rate / 100, 1);
%        ones_column = ones(vr.rate / 100, 1);
%        result_matrix = horzcat(zeros_column, zeros_column);
%        result_matrix;
%        queueOutputData(vr.ai,result_matrix);
        %channel 11
        
%        Cco4 = dataFromDAQ(:,4);
%        a = toc(vr.aaaa)
%     if (a > vr.aaaaP+5)
%         vr.aaaaP = a;
%         result_matrix = horzcat(ones_column*4, ones_column*4);
%         
%         queueOutputData(vr.ai,result_matrix);
        
%         result_matrix = horzcat(zeros_column*4, zeros_column*4);
%         result_matrix
%         queueOutputData(vr.ai,result_matrix);
%     end
    
    %sound -------- return it
    
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
    disp(vr.ao.ScansQueued)
    
    %log data
    % obtain the current timestamp
    timestamp = clock;
    
    % write timestamp and the x & y components of position and velocity to a file
    % using floating-point precision
    
    fwrite(vr.fid1, [timestamp(6) vr.velocity(2)],'double');
    
    t = linspace(double(0), double(vr.timePerSample), vr.ai.NotifyWhenDataAvailableExceeds);
    r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    %if (isempty(dataFromDAQ) == 0)
    dataFromDAQAEven = dataFromDAQ(:,1);
    dataFromDAQBEven = dataFromDAQ(:,2);
    matrix = [r1+250*vr.counter ;dataFromDAQAEven(2:2:end).';dataFromDAQBEven(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');
    vr.counter = vr.counter + 1;
    %end
    %checking position for reward
    %1 for switching to black room and 2 for jumping back to start
    
    % Create the timer object
    % Start the timer object
    if (vr.position(2)>=125)
        %vr = stopSound(vr); ---------- return it
        if (isequal(get(vr.t1, 'Running'), 'off'))
            start(vr.t1);
        end
        
        %check if the time to switch rooms has arrived
        if (timeUntilCoolOffRoom ~= 0)
            %check which room
            if (timeUntilCoolOffRoom == 1)
                vr.currentWorld = 2;
                start(vr.t2);
                vr = giveReward(vr);
               
            else
                %go back to init position
                vr.currentWorld = vr.chosenWorld;
                vr.position(2) = -100;
                %reset timers
                stop(vr.t1);
                stop(vr.t2);
            end
            timeUntilCoolOffRoom = 0;
            
            %vr.currentWorld = mod(vr.currentWorld,2)+1;
            %vr.position(2) = 0;
        end
    end
%toc(b)
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    % stop the timers
    stop(vr.t1);
    stop(vr.t2);
    delete(vr.t1);
    delete(vr.t2);
    delete(vr.lh1);
%     delete(vr.lh2);
    % stop the DAQ session
    stop(vr.ai);
    stop(vr.ao);
    % close the file
    fclose(vr.fid1);
    fclose(vr.fid2);
    vr = logData(vr);
    stopSound()
    % delete the temporary log file
%     delete(vr.tempfile);
end
