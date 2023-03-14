function x = runDirectiongpt(data)
%RUNDIRECTIONGPT Summary of this function goes here
%   Detailed explanation goes here
% Rotary encoder direction detection using MATLAB

% Define input channels
B = [1 1 0 0 1 1 0 0 1 1]; % Sample A channel signal
A = [0 1 1 0 0 1 1 0 0 1]; % Sample B channel signal

% Initialize variables
prevA = A(1); % Previous A channel value
currA = 0; % Current A channel value
prevB = 0; % Previous B channel value
currB = 0; % Current B channel value
direction = 0; % Encoder direction (0 = clockwise, 1 = counterclockwise)

% Loop through input channels
for i = 2:length(A)
    currA = A(i);
    currB = B(i);
    if (abs(currA - prevA) >= 1 && currA >= 1) % A channel has changed
        if (abs(currA - currB) >= 1) % Encoder is turning in one direction
            direction = 0; % Set direction to clockwise
        else % Encoder is turning in the other direction
            direction = 1; % Set direction to counterclockwise
        end
    end
    prevA = currA;
end

% Display direction
if (direction == 0)
    disp('Encoder is turning clockwise');
else
    disp('Encoder is turning counterclockwise');
end
end

