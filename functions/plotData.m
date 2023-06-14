function vr = plotData(vr)
    % open the binary file
    fid1 = fopen(vr.nameOfLogFileA_B);
    fid2 = fopen(vr.nameOfLogFileVel);
    fid3 = fopen(vr.nameOfLogFileReward);
    % read all data from the file into a 5-row matrix
    velocityData = fread(fid2,[3 inf],'double');
    A_B_ChannelsData = fread(fid1,[4 inf],'double');
    rewardData = fread(fid3,[2 inf],'double');
    % close the file
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);

    % plot the 2D position information
    figure;
    hold on;
    plot(velocityData(1,:),velocityData(2,:),'b-');
    plot(velocityData(1,:),velocityData(3,:),'r-');
    hold off;
    title("velocityData");
    %plot(A_B_ChannelsData(1,:),A_B_ChannelsData(2,:));
    %title("A B ChannelsData");

end

    