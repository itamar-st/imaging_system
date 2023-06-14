function vr = giveReward(vr)
    global dataFromDAQ;

    timestampCol = dataFromDAQ(:,4);
    rewardLength = vr.rate*vr.rewardDuration/1000; % how many ones to log
    data = ones(rewardLength,1)*4; % open valve for sec/10
    zero_data = zeros(vr.rate/10,1);
    vr.ao.queueOutputData(data);
    vr.ao.queueOutputData(zero_data);
    startBackground(vr.ao);
    vr.rewardOn = 1;
    columnVector = [1; 2; 3; 4; 5];

    fwrite(vr.fid3, [timestampCol(1) 1],'double');
    fwrite(vr.fid3, [timestampCol(1)+vr.rewardDuration/1000 1],'double');

%     start(vr.t3);
end