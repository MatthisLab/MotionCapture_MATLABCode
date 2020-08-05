function [segCenter_cal] = indexSegCenter(segCenter,trial_start_end,marker_mar_dim_frame,markerLabels)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function indexes segCenter data to trial_start_end frames
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
segCenter_cal = [];

%% Head marker upper extremities calibration
%Index the market/segment
segCenter_cal.HeadL =               getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'HeadL');
segCenter_cal.HeadTop =             getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'HeadTop');
segCenter_cal.HeadR =               getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'HeadR');
segCenter_cal.HeadFront =           getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'HeadFront');

%% Marker upper extremities calibration
segCenter_cal.LShoulderTop =        getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LShoulderTop');
segCenter_cal.RShoulderTop =        getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RShoulderTop');
segCenter_cal.LShoulderBack =       getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LShoulderBack');
segCenter_cal.RShoulderBack =       getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RShoulderBack');
segCenter_cal.LArm =                getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LArm');
segCenter_cal.RArm =                getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RArm');
segCenter_cal.LElbow =              getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LElbowOut');
segCenter_cal.RElbow =              getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RElbowOut');
segCenter_cal.LWristOut =           getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LWristOut');
segCenter_cal.RWristOut =           getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RWristOut');
segCenter_cal.LWristIn =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LWristIn');
segCenter_cal.RWristIn =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RWristIn');
segCenter_cal.LHandOut =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LHandOut');
segCenter_cal.RHandOut =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RHandOut');

%% Head center upper extremities calibration
segCenter_cal.HeadCenter =          segCenter.headCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.SpineTop =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'SpineTop');
segCenter_cal.ChestCenter =         segCenter.chestCenter_mar_dim_frame(:,trial_start_end);

%% SegCenter upper extremities calibration
segCenter_cal.LShoulderCenter =     segCenter.LShoulderCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RShoulderCenter =     segCenter.RShoulderCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LUpperArmCenter =     segCenter.LUpperArmCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RUpperArmCenter =     segCenter.RUpperArmCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LForearmCenter =      segCenter.LForearmCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RForearmCenter =      segCenter.RForearmCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LHandCenter =         segCenter.LHandCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RHandCenter =         segCenter.RHandCenter_mar_dim_frame(:,trial_start_end);

%% Marker lower extremities calibration
segCenter_cal.LHipFront =           getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'WaistLFront');
segCenter_cal.RHipFront =           getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'WaistRFront');
segCenter_cal.LHipBack =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'WaistLBack');
segCenter_cal.RHipBack =            getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'WaistRBack');
segCenter_cal.LKnee =               getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LKneeOut');
segCenter_cal.RKnee =               getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RKneeOut');
segCenter_cal.LAnkle =              getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LAnkleOut');
segCenter_cal.RAnkle =              getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RAnkleOut');
segCenter_cal.LToeTip =             getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'LToeTip');
segCenter_cal.RToeTip =             getMarker(marker_mar_dim_frame(:,:,trial_start_end),markerLabels,'RToeTip');

%% SegCenter lower extremities calibration
segCenter_cal.LHipCenter =          segCenter.LHipCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RHipCenter =          segCenter.RHipCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LThigh =              segCenter.LThighCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RThigh =              segCenter.RThighCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LLeg =                segCenter.LLegCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RLeg =                segCenter.RLegCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.LFoot =               segCenter.LFootCenter_mar_dim_frame(:,trial_start_end);
segCenter_cal.RFoot =               segCenter.RFootCenter_mar_dim_frame(:,trial_start_end);

end