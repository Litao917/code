%%%%%%%%%%%%%%%%%%%%%
% Make the BPM list %
%%%%%%%%%%%%%%%%%%%%%
BPMFamily = 'BPMx';
% BPMDevList = getlist(BPMFamily);
% 
% RemoveDeviceList = []; 
% i = findrowindex(RemoveDeviceList, BPMDevList); 
% BPMDevList(i,:) = [];

BPMDevList = [
     1     2
     1     3
     1     8
     1     9
     2     2
     2     3
     2     8
     2     9
     3     2
     3     3
     3     8
     3     9
     4     2
     4     3
     4     5
     4     6
     4     8
     4     9
     5     2
     5     3
     5     8
     5     9
     6     2
     6     3
     6     8
     6     9
     7     2
     7     3
     7     8
     7     9
     8     2
     8     3
     8     5
     8     6
     8     8
     8     9
     9     2
     9     3
     9     8
     9     9
    10     2
    10     3
    10     8
    10     9
    11     2
    11     3
    11     8
    11     9
    12     2
    12     3
    12     5
    12     6
    12     8
    12     9];

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean out the data directory %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[QUADFamily, QUADDev] = bpm2quad(BPMFamily, BPMDevList(1,:));
q = quadcenterinit(QUADFamily, QUADDev, 1);
DirStart = pwd;
NewDir = 'old';
q.DataDirectory = gotodirectory(q.DataDirectory);
if ~exist(NewDir,'dir')
    mkdir(NewDir);
end
try
    movefile('*.mat', NewDir);
    movefile('quadcenter.log', NewDir);
catch
end
cd(DirStart);



%%%%%%%%%%%%%%%%%%%%%%%%
% Loop on all the BPMs %
%%%%%%%%%%%%%%%%%%%%%%%%
t0 = gettime;
for i = 1:size(BPMDevList,1)
    
    [QUADFamily, QUADDev, DelSpos] = bpm2quad(BPMFamily, BPMDevList(i,:));
    
    % Check how close the BPM is to the quad (should base on phase but I didn't want to assume the AT desk was available)
    if abs(DelSpos) < 1
        fprintf('   %d. BPM(%2d,%d)  %s(%2d,%d)  BPM-to-Quad Distance=%f meters\n', i, BPMDevList(i,:), QUADFamily, QUADDev, DelSpos);

        q = quadcenter(QUADFamily, QUADDev, 0);
        
        DCCT = getdcct;    
        if DCCT < 2
            % Redo magnet if the beam dumped
            sound(cos(1:10000));
            fprintf('   Current to low.  Refill and hit return.\n');
            pause;
            fprintf(' \n');
            q = quadcenter(QUADFamily, QUADDev, 0);
            
        elseif DCCT < 35 & i<size(BPMDevList,1)-1
            sound(cos(1:10000));
            fprintf('   Current to low.  Refill and hit return.\n');
            pause;
            fprintf(' \n');
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Move data to new directory by date %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DirStart = pwd;
NewDir = sprintf('%4d-%02d-%02d_%02d-%02d-%02.0f', clock);
cd(q.DataDirectory);
if ~exist(NewDir,'dir')
    try
        mkdir(NewDir);
    catch
    end
end
try
    movefile('*.mat', NewDir);
    fprintf('   Data moved to %s\n', [q.DataDirectory NewDir]);
    try
        movefile('quadcenter.log', NewDir);
    catch
        fprintf('   Error occurred when moving log files to %s\n', [q.DataDirectory NewDir]);
    end
catch
    fprintf('   Error occurred when moving data files to %s\n', [q.DataDirectory NewDir]);
end
cd(DirStart);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print time and wake-up call %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('   Data collection time %f minutes\n', (gettime-t0)/60);
