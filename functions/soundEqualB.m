function vr = soundEqualB(vr, requiredVelocity, allowedDeviationInrange, DeviationBetweenSteps, desiredFreq)

    scale = allowedDeviationInrange; %50 in tests
    scaleOutRange = DeviationBetweenSteps;
    %return this line when finish testing
    velocity1 = vr.velocity(2)
     disp("this is "+vr.DeviationBetweenSteps);
    borderR = requiredVelocity + scale;
    borderL = requiredVelocity - scale;
    if (vr.position(2)>=vr.endOftheRoad) %if we reach to the end of the hallway
        vr = stopSound(vr);
        
    elseif ((velocity1 <= requiredVelocity + scale) && (velocity1 >= requiredVelocity - scale))
            generateSound(vr,desiredFreq);
    
    %borderR
    elseif (velocity1 > borderR)
        if (velocity1< borderR + scaleOutRange)
            generateSound(vr, desiredFreq+200);
        elseif (velocity1< borderR + 2*scaleOutRange)
            generateSound(vr, desiredFreq+400);
        elseif (velocity1< borderR + 3*scaleOutRange)
            generateSound(vr, desiredFreq+600);
        elseif (velocity1< borderR + 4*scaleOutRange)
            generateSound(vr, desiredFreq+800);
        elseif (velocity1< borderR + 5*scaleOutRange)
            generateSound(vr, desiredFreq+1000);
        else
%             disp("out of range borderR soundEqualBtest");
        end    
                
    %borderL    
    else
        if (velocity1 > borderL - scale)
            generateSound(vr, desiredFreq+200);
        elseif (velocity1> borderL - 2*scaleOutRange)
            generateSound(vr, desiredFreq+400);
        elseif (velocity1> borderL - 3*scaleOutRange)
            generateSound(vr, desiredFreq+600);
        elseif (velocity1> borderL - 4*scaleOutRange)
            generateSound(vr, desiredFreq+800);
        elseif (velocity1> borderL - 5*scaleOutRange)
            generateSound(vr, desiredFreq+1000);
        else
%             disp("out of range borderL soundEqualBtest");
        end
        
      
    end
    
end

    
    



