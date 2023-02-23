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
    shiftCounter = 0;
    sounds = double.empty;
    vr = playerInit(vr,1500);
    vr.counter = 0;
    vr.soundProfile = 0;
    vr = miniGUI(vr);
    vr.currentWorld = 1;
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
        function update_audio(obj, event)

        % Generate audio data based on the input values
        t = linspace(0, 1, 44100);
        audio_data = sin(2*pi*freq*t)';

        % Send the audio data to the audio player object
        player.queue(audio_data);
        play(player);
    end

    % Create the timer object
    t = timer('TimerFcn', @update_audio, 'Period', 0.1, 'ExecutionMode', 'fixedSpacing');
    % Start the timer object
    start(t);
    if (vr.position(2)>=125)
        disp("position runtime "+ vr.position(2))
        vr.position(2) = 125;
    end
end

% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    % stop the analog input object
    
    stop(vr.ai);
    % close the file
    fclose(vr.fid1);
    fclose(vr.fid2);
    %logData();
    % delete the temporary log file
%     delete(vr.tempfile);
end
