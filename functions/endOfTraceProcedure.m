function vr = endOfTraceProcedure(vr)
    global timeUntilCoolOffRoom;
    global dataFromDAQ;

    %1 for switching to black room and 2 for jumping back to start
    timestampCol = dataFromDAQ(:,4);
    vr = stopSound(vr);
    
    % Start the timer object   
    if (isequal(get(vr.t1, 'Running'), 'off'))
        start(vr.t1);
    end
    
    %check if the time to switch rooms has arrived
    if (timeUntilCoolOffRoom ~= 0)
        %check which room
        if (timeUntilCoolOffRoom == 1)
            vr.currentWorld = 2;
            start(vr.t2);

           if(double(vr.timeOfRanningInRange)/double(vr.timeOfTotalRun) >= vr.precentageOfRunningInRange/100)
            vr = giveReward(vr);
%                 fwrite(vr.fid3, [timestampCol(1) velocity(2)],'double');
           end

        else
            %go back to init position
            vr.countTrials = vr.countTrials + 1;
            if (vr.countTrials >= vr.amountTrials)
                vr.experimentEnded = 1;
            else    
            vr.currentWorld = vr.chosenWorld;
            vr.position(2) = -100;
            %reset timers
            stop(vr.t1);
            stop(vr.t2);
            end
        end
        timeUntilCoolOffRoom = 0;
    end
end

