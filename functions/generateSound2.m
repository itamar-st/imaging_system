function vr = generateSound(vr, freq)
%SOUND Summary of this function goes here
%   Detailed explanation goes here
    % set the frequency
   
    % create the waveform  
    global sounds;
    fs=32000; % sampling rate 1 -
    d=5; % duration of music
    n=fs*d; % number of samples
    t=(1:n)/fs; % total number of data points 
    y = cos(2*pi*freq*t);
    %sounds = horzcat(sounds{y});
    %vr.soundCounter = tic;
  %  a = toc(vr.soundCounter);
%     size(sounds,2)
%     sounds = [sounds y];
%     if (size(sounds,2) >= 3201)
%         sound(sounds,fs);
%         sounds = sounds(3201:end);
%     end
%     vr.soundCounter = tic;
% %    end
%     vr.player = audioplayer(y,fs);
%     play(vr.player)
    sound(y, fs)
    vr.checkIfSoundIsPlaying = 1;

end

