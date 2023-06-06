function vr = giveReward(vr)
    data = ones(vr.rate/10, 2)*4; % open valve for sec/10
    vr.ao.queueOutputData(data);
end