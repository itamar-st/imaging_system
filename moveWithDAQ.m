function velocity = moveWithDAQ(vr) %#ok<INUSD>
    %data = inputSingleScan(vr.ai)
    global dataFromDAQ;
    global lastDataFromDAQ;
    counter = 0;
    for i = 2:numel(dataFromDAQ(:,2))
        tmp = dataFromDAQ(:,2);
        tmp2 = tmp(i-1) + tmp(i);
        if tmp2>3 & tmp2 < 6
            counter = counter +1;
        end
    end
    %diff = data - lastDataFromDAQ;
    velocity = [0 counter 0 0]
    %calculate distance- 1024 slots / 360 deg = 2.844 slots per deg
    rotationAngle = counter*2.844;
    vr.timeOfSample;
    counter;
end