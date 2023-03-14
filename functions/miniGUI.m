function vr = miniGUI(vr)
    selectedSoundOptionIndex = 0;
    selectedWorldOptionIndex = 0;
    
% Create a cell array of options for the dropdown list
    dropdownSoundOptions = {'contenious sound', 'adjustable sound(same in both directions)', 'adjustable sound(asymetric in both directions)'};
    dropdownWorldOptions = {'World 1','World 2', 'World 3', 'World 4'}
    % Create a figure window and set its size and position
    fig = figure('Position', [550, 250, 300, 500]);

    % Create a dropdown list and set its position and options
    
    %choose sound
    uicontrol('Style', 'text', 'String', 'Choose a sound option:', 'Position', [70, 430, 150, 20]);
    dropdownSound = uicontrol('Style', 'popupmenu', 'String', dropdownSoundOptions, 'Position', [70, 400, 150, 20]);
    
    %choose world
    uicontrol('Style', 'text', 'String', 'Choose a world:', 'Position', [70, 370, 150, 20]);
    dropdownWorld = uicontrol('Style', 'popupmenu', 'String', dropdownWorldOptions, 'Position', [70, 350, 150, 20])
    
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
        
        close(fig);
        
    end
   waitfor(fig);

end

