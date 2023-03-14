function vr = soundTestgpt(vr, freq)
    %SOUNDTESTGPT Summary of this function goes here
    %   Detailed explanation goes here
    % Set up the UI components

    % Create the audio player object
    player = audioplayer(ones(44100, 1), 44100);

    % Define the timer callback function
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

    pause(1)
    %delete(t)???????????
end

