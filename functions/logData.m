function vr = logData(vr)
    global dataFromDAQ;
    % obtain the current timestamp
    timestamp = clock;
    
    % write timestamp and the x & y components of position and velocity to a file
    % using floating-point precision   
    fwrite(vr.fid1, [timestamp(6) vr.velocity(2)],'double');
    
    r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    %if (isempty(dataFromDAQ) == 0)
    dataFromDAQAEven = dataFromDAQ(:,1);
    dataFromDAQBEven = dataFromDAQ(:,2);
    matrix = [r1+250*vr.counter ;dataFromDAQAEven(2:2:end).';dataFromDAQBEven(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');
    vr.counter = vr.counter + 1;

end

