function vr = generateSoundtest(vr, freq)
%SOUND Summary of this function goes here
%   Detailed explanation goes here
    % set the frequency
   
    % create the waveform  
        
    fs=32000;
    % sampling rate 1 -
    d=0.15
    % duration of music
    n=fs*d; 
    % number of samples
    t=(1:n)/fs; % total number of data points 
    y = cos(2*pi*freq*t);
    %if (~isplaying(vr.player))
     %   vr.player = audioplayer(y,fs);
        %we use sound, because "play" didn't generate any sound. plaster 
        %clear sound
        %sound(y,fs);
      %  play(vr.player);
        
       %end
    % generate sound
    %filename='sound.wav';
    %audiowrite(filename,y,fs);
    
    % Define the audio file and the playback function
    %playbackFcn = @myCallbackFcn;

    % Create the audio player object
    %vr.player = audioplayer(y,fs);

    % Set the playback function
    %set(vr.player, 'StopFcn', playbackFcn);

    % Start the audio playback
    %play(vr.player);




end

