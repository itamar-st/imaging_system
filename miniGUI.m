function vr = miniGUI(vr)
    selectedOptionIndex = 0;    
% Create a cell array of options for the dropdown list
    dropdownOptions = {'contenious sound', 'adjustable sound(same in both directions)', 'adjustable sound(asymetric in both directions)'};

    % Create a figure window and set its size and position
    fig = figure('Position', [100, 100, 300, 100]);

    % Create a dropdown list and set its position and options
    dropdown = uicontrol('Style', 'popupmenu', 'String', dropdownOptions, 'Position', [50, 50, 200, 30]);

    % Create a button to display the selected option from the dropdown list
    button = uicontrol('Style', 'pushbutton', 'String', 'Select', 'Position', [100, 10, 100, 30], 'Callback', @buttonCallback);

   
    % Define a callback function for the button
    function buttonCallback(source, event)
        % Get the selected option from the dropdown list
        selectedOptionIndex = get(dropdown, 'Value');
        selectedOption = dropdownOptions{selectedOptionIndex};
        vr.soundProfile = selectedOptionIndex;
        % Display the selected option in a message box
        
        close(fig);
        
    end
   waitfor(fig);

end

