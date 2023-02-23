function velocity = moveWithDAQ(vr)
    global dataFromDAQ;
    global shiftCounter;
    counter = 0;
    dataFromDAQ;
    direction = runDirectiongpt(dataFromDAQ);
    Acol = dataFromDAQ(:,1);
    Bcol = dataFromDAQ(:,2);
    length = numel(Bcol);
    for i = 2:length
        tmp = Bcol(i-1) + Bcol(i);
        if tmp>3 & tmp < 6
            counter = counter +1;
        end
    end
    angle = (counter/1024)*360;
    angularSpeed = angle ./ double(vr.timeOfSample);
    speed = angularSpeed*0.09525;
    %diff = data - lastDataFromDAQ;
    velocity = [0 counter*direction 0 0];
    %calculate distance- 1024 slots / 360 deg = 2.844 slots per deg
    rotationAngle = counter*2.844;
    
    
    %log velocity
    timestamp = clock;
    fwrite(vr.fid1, [timestamp(6) velocity(2)],'double');
    
    
    %log a,b
    r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    matrix = [r1+250*shiftCounter ;Acol(2:2:end).';Bcol(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');
    shiftCounter = shiftCounter + 1
    
    
    
    
    
    if (vr.position(2)>=125) 
        velocity(2) = 0;
        disp("position move " + vr.position(2))

    end
    disp("velocity" + vr.velocity(2))

end