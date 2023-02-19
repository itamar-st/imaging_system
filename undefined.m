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
    vr.changedPos = 0;
    % reset DAQ in case it's still in use by a previous MATLAB program
    daqreset;
    % connect to the DAQ card dev1; store the input object handle in vr for use by ViRMEn
    vr.ai = daq.createSession('ni');
%     vr.ai = analoginput('nidaq','dev1');
    % start analog input channels 0 and 1
    addAnalogInputChannel(vr.ai,'Dev1',"ai1",'Voltage');
    
    vr.rotenc = daq.createSession('ni');
    vr.ch1 = addCounterInputChannel(vr.rotenc, 'Dev1', 1, 'Position');
    
    % define the sampling rate to 1kHz and set the duration to be unlimited
    set(vr.ai,'Rate',5000,'DurationInSeconds',4)
    % set the buffering window to be 8 ms long - shorter than a single ViRMEn refresh cycle
    set(vr.ai,'NotifyWhenDataAvailableExceeds',10000);
    lh = addlistener(vr.ai,'DataAvailable',@plotData);
    % define a temporary log file to be deleted at the end of the experiment
%     set(vr.ai,'loggingmode','Disk');
%     vr.tempfile = [tempname '.log'];
%     set(vr.ai,'logfilename',vr.tempfile);
    % start acquisition from the analog input object
    %function plotData(src,event)
     %    plot(event.TimeStamps,event.Data);

startBackground(vr.ai);
end




% --- RUNTIME code: executes on every iteration of the ViRMEn engine.
function vr = runtimeCodeFun(vr)
end


% --- TERMINATION code: executes after the ViRMEn engine stops.
function vr = terminationCodeFun(vr)
    % stop the analog input object
    
    stop(vr.ai);
    % delete the temporary log file
%     delete(vr.tempfile);
end
