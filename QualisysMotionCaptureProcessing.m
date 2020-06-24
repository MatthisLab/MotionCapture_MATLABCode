%% MATLAB Motion Capture Data Acquisition
clc
clear all
close all
if ispc %JSM PC
    codePath = 'C:\Users\jonma\Dropbox\ResearchProjects\GithubDesktop_DontEdit\COMPhaseSpacePlanning';
    dataPath = 'C:\Users\jonma\Google Drive\MotionCaptureProjects\Qualisys_MotionCapture\RevisedWalkingData';
elseif ismac %MT Mac
    codePath = '/Users/MT/Documents/GitHub/QualisysMotionCapture';
    dataPath = '/Users/MT/Google Drive File Stream/My Drive/MotionCaptureProjects/Qualisys_MotionCapture/RevisedWalkingData';
end

cd(codePath)
addpath(genpath(cd))
addpath(dataPath)

%% Load acquired Qualisys MoCap Data
fileName = '02_21_2020_Walking_Calibration';
[markerLabels,marker_mar_dim_frame,Force] = loadMoCapData(fileName);

%% findUser function
%function locates relevant information based on user name
%bodyMass should be in kg and height in metric units (mm)
userProfile = readtable('userProfile.xlsx','readrownames',true);
[mmHeight,kgMass] = findUser(userProfile,'Jon Matthis');

%% calcBodySegMass function
% Function outputs mass for individual body segs
[bodySegWeight,propSegWeight] = calcBodySegMass(kgMass);

%% calcSegCOM function
% Function outputs totalCOM considering marker location 
[segCenter] = calcSegCOM(marker_mar_dim_frame,markerLabels);

%% calcSegWeightCOM function
% Function outputs totalCOM depending on seg weight
[totalCOMXYZ] = calcSegWeightCOM(segCenter,propSegWeight);

%% locEmptySegFrames function
% Function outputs marker frames evaluation
[emptyFrames] = locEmptySegFrames(segCenter,totalCOMXYZ);

%% calcCOMXYZ_Vel_Acc_Jerk function
%function outputs vel,acc, and jerk values for totalCOM
[totalCOM_metrics,trial_start_end] = calcCOMXYZ_Vel_Acc_Jerk(totalCOMXYZ);

%% Calculates marker vel,acc,and jerk for trials
[head,chest,hip,LThigh,RThigh,LLeg,RLeg,LFoot,RFoot] = calcMar_Vel_Acc_Jerk(segCenter,trial_start_end);
    
%% Calculates the inst. angle for lower extremity joint
[segTheta] = calcSegAngle(marker_mar_dim_frame,markerLabels,segCenter);

%% Calculates lower extremity seg length
% units converted from mm to m
[bodySegLength] = calcBodySegLength(marker_mar_dim_frame,markerLabels,segCenter);

%% calcRadiusOfGyration function
% Function outputs radius of gyration for body segs
% units in m
[radGyra] = calcRadiusOfGyration(bodySegLength);

%% calcRadiusOfGyration function
% Function outputs radius of gyration for body segs in units of kg/m^2
[momInertia] = calcMomentOfInertia(bodySegWeight,bodySegLength,radGyra);

%% Calculates the inst. angular velocity of the lower extremity
% [segOmega,segAlpha] = calcThetaVel(segTheta);

%% Plot head, chest, hip, and feet
%Create function that plots marker in x,y,z
% plotMar_vel_acc_jerk(head,chest,hip,LThigh,RThigh,LLeg,RLeg,LFoot,RFoot);

%% Plot force plate data
plotForces(Force,trial_start_end,marker_mar_dim_frame,markerLabels)%,trial_start_end);

%% calcMarVel function
% Function outputs relative velocity of each body seg
% Currently not optimized yet for plotting purposes
%[segCenterVel] = calcMarVel(segCenter);

%% Optimizer finds location of jont center
optimizer(segCenter,marker_mar_dim_frame,markerLabels);

%% Motion capture data plot
% %Miscellaneous numbering of figures important for future reference
% f = figure(45000);
% %facilitates output of figures across multiple mediums
% f.Units = 'normalized';
% f.Position = [-0.0042 0.4306 0.9401 0.4741];
% 
% %Create video with frames
% % stepA = VideoWriter('TotalCOM_MotionCapture.mp4');
% % open(stepA);
% 
% %for frames 1:numFrames at interval of 10
% for fr = 1:10:numFrames
%     %Clear current frame
%     clf
% 
%     %Plot all markers in x,y, and z
%     plot3(marker_mar_dim_frame(:, 1, fr),...
%         marker_mar_dim_frame(:, 2, fr),...
%         marker_mar_dim_frame(:, 3, fr),'k.','MarkerFaceColor','k')
%     
%     %Hold on for next set of plotting instructions
%     hold on
%     
%     %% Total Body COM in 3D
%     %plot of total anatomical COM
%     plot3(totalCOMXYZ(1,fr),...
%         totalCOMXYZ(2,fr),...
%         totalCOMXYZ(3,fr),'p','DisplayName','TotalXYZ');
%     hold on
% 
%     %% PlotMoCapTracer function
%     %segCenter is plotted along with the anatomical markers of the subject
% %     plotMoCapTracer(segCenter)
%     
%     %% Plotting parameters
%     axis equal
%     grid on
%     legend
%     
%     %optimal x y z graph limits 
%     xlim([0 2e3])
%     ylim([-5e3 10e3]) %full lab
% %    ylim([1e3 3e3]) %smaller space
%     zlim([0 3e3])
%     
%     %unsure of what this section XYZs
%     az = -84.362;
%     el =  20.417;
%     view(az,el)
%     
%     drawnow
%     
%     %Middle of video acquisition code
% %     frame = getframe(gcf);
% %     writeVideo(stepA,frame);
%     
% end

%End of video acquisition code
% close(stepA)
