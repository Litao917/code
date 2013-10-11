function setcorrectors(FileName, varargin)
% ----------------------------------------------------------------------------------------------
% $Header: MatlabApplications/acceleratorcontrol/cls/setcorrectors.m 1.2 2007/03/02 09:17:30CST matiase Exp  $
% ----------------------------------------------------------------------------------------------
%SETMACHINECONFIG - Sets the storage ring setpoints from a file or configuratino data structure
%  setmachineconfig(FileName, ExtraInputs ...)
%  setmachineconfig(ConfigSetpoint, ExtraInputs ...)
%  
%  INPUTS
%  1. FileName - file name to storage data (including directory)
%             {default: <Directory\ConfigData><CNFArchiveFile>}
%             'Golden' will restore the golden lattice
%             The Golden lattice file name is stored in <OpsData.LatticeFile>
%
%     ConfigSetpoint - A configuration structure as returned by srsave can 
%                      also be used.
%  2. ExtraInputs - Extra inputs get passed to setpv (like 'Online' or 'Simulator')
%
%  See also getmachineconfig
%
%  Written by Greg Portmann
% ----------------------------------------------------------------------------------------------


% Get config structure
if nargin == 0
    % Default file
    %FileName = getfamilydata('Default','CNFArchiveFile');
    DirectoryName = getfamilydata('Directory','ConfigData');
    [FileName, DirectoryName] = uigetfile('*.mat', 'Select a configuration file', DirectoryName);
    if FileName == 0
        fprintf('   No change to lattice (srrestore)');
        return
    end
    load([DirectoryName FileName]);
else
    if ischar(FileName)
        if strcmpi(FileName, 'Golden')
            FileName = getfamilydata('OpsData','LatticeFile');
            DirectoryName = getfamilydata('Directory','OpsData');
            load([DirectoryName FileName]);
        else
            % Input file name
            load(FileName);
        end
    else
        ConfigSetpoint = FileName;
    end
end

FieldNameCell = fieldnames(ConfigSetpoint);

for i = 1:length(FieldNameCell)
    % Set the setpoint
    try
       if  strcmpi(FieldNameCell{i}, 'HCM') | ...
            strcmpi(FieldNameCell{i}, 'VCM') 
            % Add 100 counts to make sure CA processes the record???
            ConfigSetpoint.(FieldNameCell{i}).Data = ConfigSetpoint.(FieldNameCell{i}).Data + 0;

            %add a pause in to see if it fixes the OCH and OCV setpv's
            %setpv(ConfigSetpoint.(FieldNameCell{i}), varargin{:});
            
            for j=1:48
                fprintf('setting %s \n',FieldNameCell{i});
                %setpv(FieldNameCell{i},'Setpoint',ConfigSetpoint.(FieldNameCell{i}).Data(j), j);
                %pause(0.5);
            end
            
            
        end
    catch
        fprintf('   Trouble with setsp(%s), hence ignored (setmachineconfig)\n', FieldNameCell{i});
    end
end

% ----------------------------------------------------------------------------------------------
% $Log: MatlabApplications/acceleratorcontrol/cls/setcorrectors.m  $
% Revision 1.2 2007/03/02 09:17:30CST matiase 
% Added header/log
% ----------------------------------------------------------------------------------------------
