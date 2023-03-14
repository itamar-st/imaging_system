function vr = generateSound(vr, freq)
%SOUND Summary of this function goes here
%   Detailed explanation goes here
    % set the frequency
   
    % create the waveform  
    global sounds;
    fs=32000;
    % sampling rate 1 -
    d=0.15;
    % duration of music
    n=fs*d; 
    % number of samples
    t=(1:n)/fs; % total number of data points 
    y = cos(2*pi*freq*t);
    %sounds = horzcat(sounds{y});
    currTimer = toc;
    currTimer;
    if (currTimer > 0.14)
        sounds = [sounds y];
        %audio_matrix = cell2mat(sounds);
        sound(sounds,fs);
        sounds = sounds(2:end);
        tic
    end

end

