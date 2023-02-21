function logData()
    % open the binary file
    fid = fopen('virmenLog.dat');
    % read all data from the file into a 5-row matrix
    data = fread(fid,[2 inf],'double');
    % close the file
    fclose(fid);
    % plot the 2D position information
    plot(data(1,:),data(2,:));
    
end

