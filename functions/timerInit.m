function vr = timerInit(vr)
    global timeUntilCoolOffRoom;
    
    function coolOfRoom(val)
        timeUntilCoolOffRoom = val;
    end

    delete(timerfindall) %remove any times that are working
    %create timers for switching beween rooms
    vr.t1 = timer('TimerFcn', @(~,~)coolOfRoom(1), 'ExecutionMode', 'singleShot', 'StartDelay', vr.leakportBreak);
    vr.t2 = timer('TimerFcn', @(~,~)coolOfRoom(2), 'ExecutionMode', 'singleShot', 'StartDelay', vr.blackRoomBreak);
    
end

