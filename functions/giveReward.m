function vr = giveReward(vr)
    data = ones(vr.rate/10,1)*4; % open valve for sec/10
    zero_data = zeros(vr.rate/10,1);
    vr.ao.queueOutputData(data);
    vr.ao.queueOutputData(zero_data);
    startBackground(vr.ao);

end