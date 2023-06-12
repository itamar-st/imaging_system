function velocity = moveWithDAQ(vr)
    global dataFromDAQ;
    %if(isempty(dataFromDAQ))
     %  velocity = [0 0 0 0];
     %   return
    %end
    counter = 0;
    %direction = runDirectiongpt(dataFromDAQ);
    direction = 1;
    Acol = dataFromDAQ(:,1);
    Bcol = dataFromDAQ(:,2);
    timestampCol = dataFromDAQ(:,4);
    length = numel(Bcol);
    for i = 2:length
        tmp = Bcol(i-1) + Bcol(i);
        if tmp>3 && tmp < 6
            counter = counter +1;
        end
    end
    % extract the speed from the encoder
    angle = (counter/1024)*360; % 1024 slits in the encoder
    angularSpeed = angle ./ double(vr.timeOfSample);
    speed = angularSpeed*0.09525; % radius of 9.525 cm for the wheel.
    %diff = data - lastDataFromDAQ;
    % 10000 = 100 for 10 ms to sec * 100 for cm to meter => velocity in m\s
    scaling = 10000;
    velocity = [0 speed*scaling*direction 0 0]; 
%     velocity = [0 20 0 0];
    %calculate distance- 1024 slots / 360 deg = 2.844 slots per deg
    rotationAngle = counter*2.844;
    
    vr = logData(vr,Acol,Bcol, velocity,timestampCol);
 
    if (vr.position(2)>=125) 
        velocity(2) = 0;
    end
end