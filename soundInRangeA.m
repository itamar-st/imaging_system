function vr = soundInRangeA(vr, requiredVelocity, allowedDeviation, desiredFreq)   
    if (vr.position(2)>=vr.endOftheRoad) %if we reach to the end of the hallway
        vr = stopSound(vr);
    elseif ((requiredVelocity  <= vr.velocity(2) + allowedDeviation) && (requiredVelocity  >= vr.velocity(2) - allowedDeviation))
        vr = generateSound(vr,desiredFreq);
    else
        vr = stopSound(vr);
    end
end

