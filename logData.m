function logData()
    % open the binary file
    fid1 = fopen('A-B_record.dat');
    fid2 = fopen('virmenLog.dat');
    % read all data from the file into a 5-row matrix
    velocityData = fread(fid2,[2 inf],'double');
    A_B_ChannelsData = fread(fid1,[3 inf],'double');
    % close the file
    fclose(fid1);
    fclose(fid2);
    
    % plot the 2D position information
    
    plot(velocityData(1,:),velocityData(2,:));
    title("velocityData");
    plot(A_B_ChannelsData(1,:),A_B_ChannelsData(2,:));
    title("A B ChannelsData");

end

    