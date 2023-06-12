function vr = logData(vr,Acol,Bcol,velocity,timestampCol)
    %log velocity
%     timestamp = clock;
    fwrite(vr.fid1, [timestampCol(1) velocity(2)],'double');

    %log a,b
%     r1 = 0:(vr.ai.NotifyWhenDataAvailableExceeds/2)-1;
    matrix = [timestampCol(2:2:end).';Acol(2:2:end).';Bcol(2:2:end).'] ;
    fwrite(vr.fid2, matrix,'double');


end

