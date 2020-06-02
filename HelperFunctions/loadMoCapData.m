function [numFrames,framerate,markerLabels,numMarkers,marker_mar_dim_frame,Force] ... 
    = loadMoCapData(fileName)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%loadMoCapData outputs various variables from the file name 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
Force = [];

%% Load acquired motion capture data
%load file type of fileName and store into data variable
data = load([fileName '.mat']);

%strrep replaces substring of fileName with consistent naming convention
data = data.(['qtm_' strrep(fileName, '-', '_')]);

%store force plate, frame number, and frame rate values into vars
%numForcePlates = length(data.Force);
numFrames = data.Frames;
framerate = data.FrameRate;

%stores labeled trajectory data, marker labels, marker numbers into vars
marker_mar_dim_frameRAW = data.Trajectories.Labeled.Data;
markerLabels = data.Trajectories.Labeled.Labels;
numMarkers = data.Trajectories.Labeled.Count;
marker_mar_dim_frame = marker_mar_dim_frameRAW;

%force plate data
Force.force_plate1 = data.Force(1).Force;
Force.force_plate2 = data.Force(2).Force;
Force.force_plate3 = data.Force(3).Force;
Force.force_plate4 = data.Force(4).Force;
Force.force_plate5 = data.Force(5).Force;

end

