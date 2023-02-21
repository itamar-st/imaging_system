function velocity = moveWithDAQ(vr)
    global dataFromDAQ;
    counter = 0;
    dataFromDAQ;
    direction = runDirectiongpt(dataFromDAQ);
    Acol = abs(dataFromDAQ(:,1));
    Bcol = dataFromDAQ(:,2);
    length = numel(Bcol);
    for i = 2:length
        tmp = Bcol(i-1) + Bcol(i);
        if tmp>3 & tmp < 6
            counter = counter +1;
        end
    end
    angle = (counter/1024)*360
    angularSpeed = angle ./ double(vr.timeOfSample)
    speed = angularSpeed*0.09525
    %diff = data - lastDataFromDAQ;
    velocity = [0 counter 0 0]
    %calculate distance- 1024 slots / 360 deg = 2.844 slots per deg
    rotationAngle = counter*2.844;
    vr.timeOfSample;
    counter
    
end