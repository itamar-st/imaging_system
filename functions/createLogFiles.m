function vr = createLogFiles(vr)
    % open or create binary file for writing and store its file ID in vr
    timestampForFileName = datestr(clock);    
    vr.nameOfLogFileVel = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"velocity.dat",":");
    vr.fid1 = fopen(vr.nameOfLogFileVel,'w');
    vr.nameOfLogFileA_B = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"A-B_record.dat",":");
    vr.fid2 = fopen(vr.nameOfLogFileA_B,'w');
    vr.nameOfLogFileReward = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"Reward.dat",":");
    vr.fid3 = fopen(vr.nameOfLogFileReward,'w');
    
    
    vr.nameOfLogFileConfig = "C:\Users\user\Desktop\imaging_system\ViRMEn 2016-02-12\config\config.json";

%     vr.nameOfLogFileCurrentConfig = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"Reward.dat",":");
%     vr.fid4 = fopen(vr.nameOfLogFileCurrentConfig,'w');
end

