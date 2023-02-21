function vr = soundInRangeA(vr, requiredVelocity)
%CALCVELOCITY Summary of this function goes here
%if ((requiredVelocity  <= 7) && (requiredVelocity  >= 3))    
    if ((requiredVelocity  <= vr.velocity(2) + 10) && (requiredVelocity  >= vr.velocity(2) - 10))
            generateSound(vr,1500);
    end    
end

