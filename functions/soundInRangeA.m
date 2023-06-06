function vr = soundInRangeA(vr, requiredVelocity, allowedDeviation, desiredFreq)   
    if ((requiredVelocity  <= vr.velocity(2) + allowedDeviation) && (requiredVelocity  >= vr.velocity(2) - allowedDeviation))
        vr = generateSound(vr,desiredFreq);
    else
        vr = stopSound(vr);
    end
end

