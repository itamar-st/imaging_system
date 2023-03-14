function vr = soundDiffC(vr, requiredVelocity,desiredFreq)
%velocity1 has to be changed back to vr.velocity(2)

%CALCVELOCITY Summary of this function goes here
%if ((requiredVelocity  <= 7) && (requiredVelocity  >= 3))   
    scale = 50;
    velocity1 = vr.velocity(2);
   
    borderR = requiredVelocity + scale;
    borderL = requiredVelocity - scale;
    
    if ((velocity1 <= requiredVelocity + scale) && (velocity1 >= requiredVelocity - scale))
            generateSound(vr,desiredFreq);
    %else
    
    %borderR
    elseif (velocity1 > borderR)
        if (velocity1< borderR + scale)
            generateSound(vr, desiredFreq+200);
        elseif (velocity1< borderR + 2*scale)
            generateSound(vr, desiredFreq+400);
        elseif (velocity1< borderR + 3*scale)
            generateSound(vr, desiredFreq+600);
        elseif (velocity1< borderR + 4*scale)
            generateSound(vr, desiredFreq+800);
        elseif (velocity1< borderR + 5*scale)
            generateSound(vr, desiredFreq+1000);
        else
            disp("out of range borderR soundEqualBtest");
        end    
        
        
        
    %borderL    
    else
        if (velocity1 > borderL - scale)
            generateSound(vr, desiredFreq-200);
        elseif (velocity1> borderL - 2*scale)
            generateSound(vr, desiredFreq-400);
        elseif (velocity1> borderL - 3*scale)
            generateSound(vr, desiredFreq-600);
        elseif (velocity1> borderL - 4*scale)
            generateSound(vr, desiredFreq-800);
        elseif (velocity1> borderL - 5*scale)
            generateSound(vr, desiredFreq-1000);
        else
            disp("out of range borderL soundEqualBtest");
        end
        
        
    end
    
    
end

    
    



