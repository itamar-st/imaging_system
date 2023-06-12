function vr = endOfTraceProcedure(vr)
    global timeUntilCoolOffRoom;
    %1 for switching to black room and 2 for jumping back to start
    
    % Create the timer object
    % Start the timer object
    vr = stopSound(vr);
    if (isequal(get(vr.t1, 'Running'), 'off'))
        start(vr.t1);
    end

    %check if the time to switch rooms has arrived
    if (timeUntilCoolOffRoom ~= 0)
        %check which room
        if (timeUntilCoolOffRoom == 1)
            vr.currentWorld = 2;
            start(vr.t2);
            vr = giveReward(vr);

        else
            %go back to init position
            vr.currentWorld = vr.chosenWorld;
            vr.position(2) = -100;
            %reset timers
            stop(vr.t1);
            stop(vr.t2);
        end
        timeUntilCoolOffRoom = 0;
    end
end
