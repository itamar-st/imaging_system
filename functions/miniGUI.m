function vr = miniGUI(vr)
    selectedSoundOptionIndex = 0;
    selectedWorldOptionIndex = 0;
    
% Create a cell array of options for the dropdown list
    dropdownSoundOptions = {'contenious sound', 'adjustable sound(same in both directions)', 'adjustable sound(asymetric in both directions)'};
    dropdownWorldOptions = {'World 1','World 2', 'World 3', 'World 4'}
    % Create a figure window and set its size and position
    fig = figure('Position', [550, 250, 300, 600]);

    % Create a dropdown list and set its position and options
    %how long to open the valve
    uicontrol('Style', 'text', 'String', 'reward duration (ms):', 'Position', [70, 500, 150, 20]);    
    % Create a slider control for leakport break
    sliderValveDuration = uicontrol('Style', 'slider', 'Position', [70, 480, 150, 20], 'Min', 0, 'Max', 1000, 'Value', 100, 'SliderStep', [0.01 0.1], 'Callback', @sliderValveDurationCallback);
    sliderValveDurationText = uicontrol('Style', 'text', 'Position', [70, 460, 150, 20], 'String', 'Slider Value: 100');

    function sliderValveDurationCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderValveDuration, 'Value'));
       %changes in gui
       set(sliderValveDurationText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
    %choose sound
    uicontrol('Style', 'text', 'String', 'Choose a sound option:', 'Position', [70, 430, 150, 20]);
    dropdownSound = uicontrol('Style', 'popupmenu', 'String', dropdownSoundOptions, 'Position', [70, 400, 150, 20]);
    
    %choose world
    uicontrol('Style', 'text', 'String', 'Choose a world:', 'Position', [70, 370, 150, 20]);
    dropdownWorld = uicontrol('Style', 'popupmenu', 'String', dropdownWorldOptions, 'Position', [70, 350, 150, 20]);
    
    %how long in leak port room
    uicontrol('Style', 'text', 'String', 'leak port break:', 'Position', [70, 320, 150, 20]);    
    % Create a slider control for leakport break
    sliderLeakport = uicontrol('Style', 'slider', 'Position', [70, 300, 150, 20], 'Min', 0, 'Max', 100, 'Value', 2, 'SliderStep', [0.01 0.1], 'Callback', @sliderLeakportCallback);
    sliderValueLeakportText = uicontrol('Style', 'text', 'Position', [70, 280, 150, 20], 'String', 'Slider Value: 2');

    function sliderLeakportCallback(source, event)
       selectedSliderLeakportValue = round(get(sliderLeakport, 'Value'));
       %changes in gui
       set(sliderValueLeakportText, 'String', sprintf('Slider Value: %d', selectedSliderLeakportValue));
    end
 
    %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'black room break:', 'Position', [70, 240, 150, 20]);
    sliderBlackroom = uicontrol('Style', 'slider', 'Position', [70, 220, 150, 20], 'Min', 0, 'Max', 100, 'Value', 2, 'SliderStep', [0.01 0.1], 'Callback', @sliderBlackRoomCallback);
    sliderValueBlackRoomText = uicontrol('Style', 'text', 'Position', [70, 200, 150, 20], 'String', 'Slider Value: 2');
   
    function sliderBlackRoomCallback(source, event)
       selectedSliderBlackRoomValue = round(get(sliderBlackroom, 'Value'));
       %changes in gui
       set(sliderValueBlackRoomText, 'String', sprintf('Slider Value: %d', selectedSliderBlackRoomValue));
    end
    
 
    %deviation
     %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'deviation from target sound:', 'Position', [70, 160, 150, 20]);
    sliderDeviation = uicontrol('Style', 'slider', 'Position', [70, 140, 150, 20], 'Min', 0, 'Max', 100, 'Value', 15, 'SliderStep', [0.01 0.1], 'Callback', @sliderDeviationCallback);
    sliderValueDeviationText = uicontrol('Style', 'text', 'Position', [70, 120, 150, 20], 'String', 'Slider Value: 15');
   
    function sliderDeviationCallback(source, event)
       selectedSliderDevValue = round(get(sliderDeviation, 'Value'));
       %changes in gui
       set(sliderValueDeviationText, 'String', sprintf('Slider Value: %d', selectedSliderDevValue));
    end
 

    %target speed
     %create a slider control for black room break
    uicontrol('Style', 'text', 'String', 'target speed:', 'Position', [70, 80, 150, 20]);
    sliderTargetSpeed = uicontrol('Style', 'slider', 'Position', [70, 60, 150, 20], 'Min', 0, 'Max', 100, 'Value', 30, 'SliderStep', [0.01 0.1], 'Callback', @sliderTargetSpeedCallback);
    sliderValueTargetSpeedText = uicontrol('Style', 'text', 'Position', [70, 40, 150, 20], 'String', 'Slider Value: 30');
   
    function sliderTargetSpeedCallback(source, event)
       selectedSliderTargetSpeedValue = round(get(sliderTargetSpeed, 'Value'));
       %changes in gui
       set(sliderValueTargetSpeedText, 'String', sprintf('Slider Value: %d', selectedSliderTargetSpeedValue));
    end
 

    % Create a button to display the selected option from the dropdown list
    button = uicontrol('Style', 'pushbutton', 'String', 'Select', 'Position', [100, 10, 100, 30], 'Callback', @buttonCallback);

   
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
        
        %target speed
        vr.targetSpeed = get(sliderTargetSpeed, 'Value');
        
        %reward duration
        vr.rewardDuration = get(sliderValveDuration, 'Value');
        close(fig);
        
    end
   waitfor(fig);

end

