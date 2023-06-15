function vr = endOfTraceProcedure(vr)
    global timeUntilCoolOffRoom;
    global dataFromDAQ;

    %1 for switching to black room and 2 for jumping back to start
    timestampCol = dataFromDAQ(:,4);
    vr = stopSound(vr);
    
    % Start the timer object   
    if (isequal(get(vr.t1, 'Running'), 'off'))
        start(vr.t1);
        if((double(vr.timeOfRanningInRange)/double(vr.timeOfTotalRun) >= vr.precentageOfRunningInRange/100)&&(vr.isRewardGiven == 0 ))
            vr = giveReward(vr);
            vr.isRewardGiven = 1;
        end
    end
    
    %check if the time to switch rooms has arrived
    if (timeUntilCoolOffRoom ~= 0)
        %check which room
        if (timeUntilCoolOffRoom == 1)
            vr.currentWorld = 2;
            if (isequal(get(vr.t2, 'Running'), 'off'))
                start(vr.t2);
            end

        else
            %go back to init position
            vr.countTrials = vr.countTrials + 1;
            if (vr.countTrials >= vr.amountTrials)
                vr.experimentEnded = 1;
            else
                randomNumber = rand;
                if (randomNumber > 0.5)
                    vr.currentWorld = 1;
                else
                    vr.currentWorld = 3;
                end
                %vr.currentWorld = vr.chosenWorld;
                vr.position(2) = -250;
                vr.isRewardGiven = 0;
                %reset timers
                stop(vr.t1);
                stop(vr.t2);
            end
        end
        timeUntilCoolOffRoom = 0;
    end
end

