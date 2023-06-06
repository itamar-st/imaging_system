function x = runDirection(data)
%RUNDIRECTION Summary of this function goes here
%   Detailed explanation goes here
x = 0
Acol = abs(data(:,1));
Bcol = data(:,2);


old_state = Acol(1);
length = numel(Bcol);

for i = 2:length
    
    state = Acol(i);
    %if state diff than old_state
    if (abs(state - old_state) > 2 )
        if (abs(Bcol(i) - state) > 2)
            x = x + 1;
        else 
            x = x - 1;
        end
    end    
   x     
end
end

