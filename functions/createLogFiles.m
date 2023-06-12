function vr = createLogFiles(vr)
    % open or create binary file for writing and store its file ID in vr
    timestampForFileName = datestr(clock);    
    vr.nameOfLogFileVel = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"velocity.dat",":");
    vr.fid1 = fopen(vr.nameOfLogFileVel,'w');
    vr.nameOfLogFileA_B = "C:\Users\user\Desktop\imaging_system\log\" + erase(timestampForFileName+"A-B_record.dat",":");
    vr.fid2 = fopen(vr.nameOfLogFileA_B,'w');
end

