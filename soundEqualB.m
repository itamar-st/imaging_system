function vr = soundEqualB(vr, requiredVelocity,desiredFreq)
%CALCVELOCITY Summary of this function goes here
%if ((requiredVelocity  <= 7) && (requiredVelocity  >= 3))   
    scale = 15;
    if ((requiredVelocity  <= vr.velocity(2) + 10) && (requiredVelocity  >= vr.velocity(2) - 10))
            generateSound(vr,desiredFreq);
    else 
        anomaly = abs(requiredVelocity - vr.velocity(2))
        if(anomaly >= scale && anomaly < 2*scale) 
        generateSound(vr, desiredFreq+200);
        
        elseif(anomaly >= 2*scale && anomaly < 3*scale) 
        generateSound(vr, desiredFreq+400);
        
        elseif(anomaly >= 3*scale && anomaly < 4*scale) 
        generateSound(vr, desiredFreq+600);
        
        elseif(anomaly >= 4*scale && anomaly < 5*scale) 
        generateSound(vr, desiredFreq+800);
        
        elseif(anomaly >= 5*scale && anomaly < 6*scale) 
        generateSound(vr, desiredFreq+1000);
        else
            disp("hello");
        end
    end    
end


