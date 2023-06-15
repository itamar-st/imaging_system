function vr = DAQInit(vr)
    global dataFromDAQ;
    vr.rate = 20000;
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
    vr.ai.IsContinuous = true;
    
    vr.ao = daq.createSession('ni');
    vr.ao.IsContinuous = true;
    
    addAnalogInputChannel(vr.ai,'Dev1',[8,9,10],'Voltage');
    addAnalogOutputChannel(vr.ao,'Dev1',1,'Voltage');
    % define the sampling rate to 1kHz and set the duration to be unlimited
    vr.ai.Rate = vr.rate;
    vr.ao.Rate = vr.rate;
            
    initialData = zeros(vr.rate,1);
    vr.ao.queueOutputData(initialData);

    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    vr.ai.NotifyWhenDataAvailableExceeds = vr.rate / 100;
    vr.ao.NotifyWhenScansQueuedBelow  = vr.rate/10;

    vr.timeOfSample = vr.ai.Rate./vr.ai.NotifyWhenDataAvailableExceeds;
    vr.timePerSample = vr.ai.NotifyWhenDataAvailableExceeds./vr.ai.Rate;
    vr.lh1 = addlistener(vr.ai,'DataAvailable',@getData);
    function getData(src,event)
        dataFromDAQ = [event.Data event.TimeStamps];
    end

    % start acquisition from the analog input object
    startBackground(vr.ai);
    startBackground(vr.ao);
end
