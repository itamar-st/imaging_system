function x = runDirectiongpt(data)
    %RUNDIRECTIONGPT Summary of this function goes here
    %   Detailed explanation goes here
    % Rotary encoder direction detection using MATLAB
    % Define input channels
   
    % if (isempty(data))
    %    x = 0;
    %    return;
    %end   
    
    A = data(:,1); % Sample A channel signal
    B = data(:,2); % Sample B channel signal
    % Initialize variables
    prevA = A(1); % Previous A channel value
    currA = 0; % Current A channel value
    currB = 0; % Current B channel value
    x = 0; % Encoder direction (0 = clockwise, 1 = counterclockwise)
    % Loop through input channels
    for i = 2:length(A)
        currA = A(i);
        currB = B(i);
        if (abs(currA - prevA) >= 2 && currA >= 2) % A channel has changed
            if (abs(currA - currB) >= 2) % Encoder is turning in one direction
                x = 1; % Set direction to clockwise
                break
            else % Encoder is turning in the other direction
                x = -1; % Set direction to counterclockwise
                break
            end
        end
        prevA = currA;
    end

% Display direction
%if (direction == 0)
 %   disp('Encoder is turning clockwise');
%else
%    disp('Encoder is turning counterclockwise');
%end
end

