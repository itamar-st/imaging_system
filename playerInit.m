function vr = playerInit(vr, freq)
%SOUND Summary of this function goes here
%   Detailed explanation goes here
    % set the frequency
    % create the waveform
    fs=32000;
    % sampling rate 1 -
    d=0.15;
    % duration of music
    n=fs*d; 
    % number of samples
    t=(1:n)/fs; % total number of data points 
    y = cos(2*pi*freq*t);
    vr.player = audioplayer(y,fs);    

end

