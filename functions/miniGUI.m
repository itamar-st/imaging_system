function vr = miniGUI(vr)

    selectedSoundOptionIndex = 0;
    selectedWorldOptionIndex = 0;

    %%%%%%%%%%%%%%%%%%%%
   
   % Read the JSON file
jsonStr = fileread(vr.nameOfLogFileConfig);

% Decode the JSON string
jsonData = jsondecode(jsonStr);

% Create a dictionary-like structure
dict = containers.Map;

% Iterate over the fields in the JSON data and populate the dictionary
fields = fieldnames(jsonData);
for i = 1:numel(fields)
    field = fields{i};
    dict(field) = jsonData.(field);
end
    % Access the value corresponding to a key
   
    %%%%%%%%%%%%%%%%%%%%
    % Create a cell array of options for the dropdown list
    dropdownSoundOptions = {'contenious sound', 'adjustable sound(same in both directions)', 'adjustable sound(asymetric in both directions)'};
    dropdownWorldOptions = {'World 1','World 2', 'World 3', 'World 4'};
    % Create a figure window and set its size and position
    fig = figure('Position', [550, 250, 300, 700]);

    %amount of trials in a session
    uicontrol('Style', 'text', 'String', 'Amount of trials:', 'Position', [70, 660, 150, 20]);
    sliderAmountTrials = uicontrol('Style', 'slider', 'Position', [70, 640, 150, 20], 'Min', 0, 'Max', 500, 'Value', str2double(dict('db_amount_trials')), 'SliderStep', [0.002 0.1], 'Callback', @sliderAmountTrialsCallback);
    sliderAmountTrialsText = uicontrol('Style', 'text', 'Position', [70, 620, 150, 20], 'String', ['Slider Value: ', dict('db_amount_trials')]);

    function sliderAmountTrialsCallback(source, event)
       selectedSliderAmountTrials = round(get(sliderAmountTrials, 'Value'));
       %changes in gui
       set(sliderAmountTrialsText, 'String', sprintf('Slider Value: %d', selectedSliderAmountTrials));
    end
    
    %percentage threshold to open leakport
    uicontrol('Style', 'text', 'String', 'Threshold for leakport:', 'Position', [70, 600, 150, 20]);
    sliderPercentageThreshold = uicontrol('Style', 'slider', 'Position', [70, 580, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_threshold_open_valve')), 'SliderStep', [0.01 0.1], 'Callback', @sliderPercentageThresholdCallback);
    sliderPercentageThresholdText = uicontrol('Style', 'text', 'Position', [70, 560, 150, 20], 'String', ['Slider Value: ', dict('db_threshold_open_valve')]);
   
    function sliderPercentageThresholdCallback(source, event)
       selectedSliderPercentageThreshold = round(get(sliderPercentageThreshold, 'Value'));
       %changes in gui
       set(sliderPercentageThresholdText, 'String', sprintf('Slider Value: %d', selectedSliderPercentageThreshold));
    end

    %how long to open the valve
    uicontrol('Style', 'text', 'String', 'reward duration (ms):', 'Position', [70, 540, 150, 20]);    
    % Create a slider control for leakport break
    sliderValveDuration = uicontrol('Style', 'slider', 'Position', [70, 520, 150, 20], 'Min', 0, 'Max', 1000, 'Value', str2double(dict('db_reward_duration')), 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationCallback);
    sliderValveDurationText = uicontrol('Style', 'text', 'Position', [70, 500, 150, 20], 'String', ['Slider Value: ', dict('db_reward_duration')]);

    function sliderValveDurationCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderValveDuration, 'Value'));
       %changes in gui
       set(sliderValveDurationText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
    
    %choose sound - opens dropdown options list to choose sound from
    uicontrol('Style', 'text', 'String', 'Choose a sound option:', 'Position', [70, 480, 150, 20]);
    dropdownSound = uicontrol('Style', 'popupmenu', 'String', dropdownSoundOptions, 'Position', [70, 460, 150, 20]);
    % Set the default choice
    defaultChoiceIndex = str2double(dict('db_sound_option'));  % Set the index of the desired default choice
    set(dropdownSound, 'Value', defaultChoiceIndex);


    %choose world
    uicontrol('Style', 'text', 'String', 'Choose a world:', 'Position', [70, 430, 150, 20]);
    dropdownWorld = uicontrol('Style', 'popupmenu', 'String', dropdownWorldOptions, 'Position', [70, 410, 150, 20]);
    
    %how long in leak port room
    uicontrol('Style', 'text', 'String', 'leak port break:', 'Position', [70, 380, 150, 20]);    
    % Create a slider control for leakport break
    sliderLeakport = uicontrol('Style', 'slider', 'Position', [70, 360, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_leakport_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderLeakportCallback);
    sliderValueLeakportText = uicontrol('Style', 'text', 'Position', [70, 340, 150, 20], 'String', ['Slider Value: ', dict('db_leakport_room_break')]);

    function sliderLeakportCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderLeakport, 'Value'));
       %changes in gui
       set(sliderValueLeakportText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
 
    %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'black room break:', 'Position', [70, 310, 150, 20]);
    sliderBlackroom = uicontrol('Style', 'slider', 'Position', [70, 290, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_black_room_break')), 'SliderStep', [0.01 0.1], 'Callback', @sliderBlackRoomCallback);
    sliderValueBlackRoomText = uicontrol('Style', 'text', 'Position', [70, 270, 150, 20], 'String', ['Slider Value: ', dict('db_black_room_break')]);
   
    function sliderBlackRoomCallback(source, event)
       selectedSliderBlackRoomValue = round(get(sliderBlackroom, 'Value'));
       %changes in gui
       set(sliderValueBlackRoomText, 'String', sprintf('Slider Value: %d', selectedSliderBlackRoomValue));
    end
    
 
    %deviation
     %create a slider control for deviation from target sound,it is  the stair of the good range
    uicontrol('Style', 'text', 'String', 'deviation from target sound:', 'Position', [70, 250, 150, 20]);
    sliderDeviation = uicontrol('Style', 'slider', 'Position', [70, 230, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_in_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationCallback);
    sliderValueDeviationText = uicontrol('Style', 'text', 'Position', [70, 210, 150, 20], 'String', ['Slider Value: ', dict('db_sound_deviation_in_range')]);
   
    function sliderDeviationCallback(source, event)
       selectedSliderDevValue = round(get(sliderDeviation, 'Value'));
       %changes in gui
       set(sliderValueDeviationText, 'String', sprintf('Slider Value: %d', selectedSliderDevValue));
    end
 

    %target speed
     %create a slider control for target speed
    uicontrol('Style', 'text', 'String', 'target speed:', 'Position', [70, 190, 150, 20]);
    sliderTargetSpeed = uicontrol('Style', 'slider', 'Position', [70, 170, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_target_speed')), 'SliderStep', [0.01 0.1], 'Callback', @sliderTargetSpeedCallback);
    sliderValueTargetSpeedText = uicontrol('Style', 'text', 'Position', [70, 150, 150, 20], 'String', ['Slider Value: ', dict('db_target_speed')]);
   
    function sliderTargetSpeedCallback(source, event)
       selectedSliderTargetSpeedValue = round(get(sliderTargetSpeed, 'Value'));
       %changes in gui
       set(sliderValueTargetSpeedText, 'String', sprintf('Slider Value: %d', selectedSliderTargetSpeedValue));
    end
 
    %stair deviation of sound out of range
    uicontrol('Style', 'text', 'String', 'deviation sound out of range:', 'Position', [70, 130, 150, 20]);
    sliderDeviationOutOfRange = uicontrol('Style', 'slider', 'Position', [70, 110, 150, 20], 'Min', 0, 'Max', 100, 'Value', str2double(dict('db_sound_deviation_out_range')), 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationOutOfRangeCallback);
    sliderValueDeviationOutOfRangeText = uicontrol('Style', 'text', 'Position', [70, 90, 150, 20], 'String', ['Slider Value: ', dict('db_sound_deviation_out_range')]);
   
    function sliderDeviationOutOfRangeCallback(source, event)
       selectedSliderDevOutOfRangeValue = round(get(sliderDeviationOutOfRange, 'Value'));
       %changes in gui
       set(sliderValueDeviationOutOfRangeText, 'String', sprintf('Slider Value: %d', selectedSliderDevOutOfRangeValue));
    end

    % Create a button to display the selected option from the dropdown list
    button = uicontrol('Style', 'pushbutton', 'String', 'Select', 'Position', [100, 50, 100, 30], 'Callback', @buttonCallback);

   
    % Define a callback function for the button
    function buttonCallback(source, event)
        % Get the selected option from the dropdown list
        %sound
        selectedSoundOptionIndex = get(dropdownSound, 'Value');
        vr.soundProfile = selectedSoundOptionIndex;
        
        %world
        selectedWorldOptionIndex = get(dropdownWorld,'Value');
        vr.chosenWorld = selectedWorldOptionIndex;

        %leakport break
        vr.leakportBreak = get(sliderLeakport, 'Value');
        
        %Black Room break;
        vr.blackRoomBreak = get(sliderBlackroom, 'Value');
        
        %deviation allowed
        vr.allowedDeviation = get(sliderDeviation, 'Value');
        
        %deviation out of range for sound B and C
        vr.DeviationBetweenSteps = get(sliderDeviationOutOfRange, 'Value');
        
        %target speed
        vr.targetSpeed = get(sliderTargetSpeed, 'Value');
        
        %reward duration
        vr.rewardDuration = get(sliderValveDuration, 'Value');
        
        %Percentage threshold to open leakport
        vr.precentageOfRunningInRange = get(sliderPercentageThreshold, 'Value');
        
        %amount of trials
        vr.amountTrials = get(sliderAmountTrials, 'Value');
        close(fig);
        
    end
   waitfor(fig);

end

