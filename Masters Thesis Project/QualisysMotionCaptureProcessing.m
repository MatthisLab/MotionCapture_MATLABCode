%% MATLAB Motion Capture Data Acquisition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Index start and end of gait cycle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
if ispc %JSM PC
    codePath = 'C:\Users\jonma\Dropbox\ResearchProjects\GithubDesktop_DontEdit\COMPhaseSpacePlanning';
    dataPath = 'C:\Users\jonma\Google Drive\MotionCaptureProjects\Qualisys_MotionCapture\RevisedWalkingData';
elseif ismac %MT Mac
    %codePath = '/Users/MT/Documents/GitHub/QualisysMotionCapture';
    codePath = '/Users/MT/Documents/GitHub/QualisysMotionCapture/Masters Thesis Project';
    dataPath = '/Users/MT/Google Drive File Stream/My Drive/MotionCaptureProjects/Matheus_Qualisys_Walking_Trials/Thesis_Trials/mat_files';
    %dataPath = '/Users/MT/Documents/GitHub/QualisysMotionCapture/Masters Thesis Project/mat_trials';
    %dataPath = '/Users/MT/Google Drive File Stream/My Drive/MotionCaptureProjects/Matheus_Qualisys_Walking_Trials/Thesis_Trials/mat_files';
end

cd(codePath)
addpath(genpath(cd))
addpath(dataPath)

%% Experiment Info 
%What is a trial?
total_trials =   24;

%What is a cond
trial_cond =     1;      %req for formatting trial results

for trial_num = 1:total_trials
    %% Initial conditions of data set
    %function locates relevant information based on user name
    %bodyMass should be in kg and height in metric units (mm)
    user_profile = readtable('userProfile.xlsx','readrownames',true);
    [mm_height,kg_mass] = find_user(user_profile,'MFBT'); %Change to initials
    
    %% Load acquired Qualisys MoCap Data
    %fileName = '02_21_2020_Walking_Calibration';
    file_name = strcat('Matheus_ThesisFW001_Trial',num2str(trial_num),'.mat');
    [marker_labels,marker_mar_dim_frame,Force,num_frames] = load_mo_cap_data(file_name,trial_num);
    
    %% calcBodySegMass function
    % Function outputs mass for individual body segs
    [body_seg_weight,prop_seg_weight] = calc_body_seg_mass(kg_mass);
    
    %% calcSegCOM function
    % Function outputs seg_center considering marker location
    [seg_center] = calc_seg_COM(marker_mar_dim_frame,marker_labels);
    
    %% calcSegWeightCOM function
    % Function outputs totalCOM depending on seg weight
    [total_body_COMXYZ] = calc_seg_weight_COM(seg_center,prop_seg_weight);
    
    %% locEmptySegFrames function
    % Function outputs marker frames evaluation
    [empty_frames] = loc_empty_seg_frames(seg_center,total_body_COMXYZ);
    
    %% calcCOMXYZ_Vel_Acc_Jerk function
    %function outputs vel,acc, and jerk values for totalCOM
    [totalCOM_metrics,trial_start_end,vel_start_end,acc_start_end] = calc_COMXYZ_vel_acc_jerk(total_body_COMXYZ,num_frames);
    
%     %% Calibrates seg_center data using trial start and end frames
%     [seg_center_cal] = index_seg_center(seg_center,trial_start_end,marker_mar_dim_frame,marker_labels);
%     
%     %% Calibrates force data using trial start and end frames
%     [Force_cal] = index_force(Force,trial_start_end);
    
    %% Calculates marker vel,acc,and jerk for trials
    [head,chest,hip,LThigh,RThigh,LLeg,RLeg,LFoot,RFoot] = calc_mar_vel_acc_jerk(seg_center,trial_start_end);
    
    %% Plot head, chest, hip, and feet
    %Create function that plots marker in x,y,z
    %plot_mar_vel_acc_jerk(head,chest,hip,LThigh,RThigh,LLeg,RLeg,LFoot,RFoot,trial_num,vel_start_end,acc_start_end);
    
    %% Identify heel strike and toe off in gait cycle
    [LFoot_HS,LFoot_TO,RFoot_HS,RFoot_TO] = locate_TO_HS(LFoot,RFoot,trial_num);
    
    %% Index steps through kinematic chain
    all_HS = sort([LFoot_HS RFoot_HS]);
    [avg_num_steps,head_steps,chest_steps,hip_steps,LThigh_steps,RThigh_steps,LLeg_steps,RLeg_steps,LFoot_steps,RFoot_steps] = kin_chain_steps(head,chest,hip,LThigh,RThigh,LLeg,RLeg,LFoot,RFoot,all_HS,trial_num);
    
    %% Extract steps_acc and steps_acc values from trials
    trial_avg_num_steps(trial_num) = avg_num_steps;
    
    head_trials_steps_vel(trial_num) = head_steps(1);
    head_trials_steps_acc(trial_num) = head_steps(2);
    
    chest_trials_steps_vel(trial_num) = chest_steps(1);
    chest_trials_steps_acc(trial_num) = chest_steps(2);
    
    hip_trials_steps_vel(trial_num) = hip_steps(1);
    hip_trials_steps_acc(trial_num) = hip_steps(2);
    
    % Thigh values
    LThigh_trials_steps_vel(trial_num) = LThigh_steps(1);
    LThigh_trials_steps_acc(trial_num) = LThigh_steps(2);
    RThigh_trials_steps_vel(trial_num) = RThigh_steps(1);
    RThigh_trials_steps_acc(trial_num) = RThigh_steps(2);
    
    % Leg values
    LLeg_trials_steps_vel(trial_num) = LLeg_steps(1);
    LLeg_trials_steps_acc(trial_num) = LLeg_steps(2);
    RLeg_trials_steps_vel(trial_num) = RLeg_steps(1);
    RLeg_trials_steps_acc(trial_num) = RLeg_steps(2);
    
    % Foot values
    LFoot_trials_steps_vel(trial_num) = LFoot_steps(1);
    LFoot_trials_steps_acc(trial_num) = LFoot_steps(2);
    RFoot_trials_steps_vel(trial_num) = RFoot_steps(1);
    RFoot_trials_steps_acc(trial_num) = RFoot_steps(2);
    
end

%% Experiment Data Processing
plot_trial_steps_acc(head_trials_steps_acc,chest_trials_steps_acc,hip_trials_steps_acc,LThigh_trials_steps_acc,RThigh_trials_steps_acc,LLeg_trials_steps_acc,RLeg_trials_steps_acc,LFoot_trials_steps_acc,RFoot_trials_steps_acc,trial_num)

%% Experiment Qualifications
% [head_stats,chest_stats,hip_stats,Thigh_stats,Leg_stats,Foot_stats = stat_eval_exp(

% Analysis of overall experiment
all_trials_steps =      sum(trial_avg_num_steps);
avg_all_trials_steps =  mean(trial_avg_num_steps);
std_all_trials_steps =  std(trial_avg_num_steps);

% Stats on head trials
avg_head_acc = mean(head_trials_steps_acc);
std_head_acc = std(head_trials_steps_acc);

% Stats on chest trials
avg_chest_acc = mean(chest_trials_steps_acc);
std_chest_acc = std(chest_trials_steps_acc);

% Stats on hip trials
avg_hip_acc = mean(hip_trials_steps_acc);
std_hip_acc = std(hip_trials_steps_acc);

% Stats on thigh trials
avg_LThigh_acc = mean(LThigh_trials_steps_acc);
std_LThigh_acc = std(LThigh_trials_steps_acc);
avg_RThigh_acc = mean(RThigh_trials_steps_acc);
std_RThigh_acc = std(RThigh_trials_steps_acc);

% Stats on leg trials
avg_LLeg_acc = mean(LLeg_trials_steps_acc);
std_LLeg_acc = std(LLeg_trials_steps_acc);
avg_RLeg_acc = mean(RLeg_trials_steps_acc);
std_RLeg_acc = std(RLeg_trials_steps_acc);

% Stats on foot trials
avg_LFoot_acc = mean(LFoot_trials_steps_acc);
std_LFoot_acc = std(LFoot_trials_steps_acc);
avg_RFoot_acc = mean(RFoot_trials_steps_acc);
std_RFoot_acc = std(RFoot_trials_steps_acc);

for jj = 1:9
    figure(21223);
    
    % Set y values
    kin_exp_acc = [avg_head_acc avg_chest_acc avg_hip_acc avg_LThigh_acc avg_RThigh_acc avg_LLeg_acc avg_RLeg_acc avg_LFoot_acc avg_RFoot_acc];
    kin_exp_acc(jj) = kin_exp_acc(jj);
    
    kin_labels = ["head","chest","hip","LThigh","RThigh","LLeg","RLeg","LFoot","RFoot"];
    
    % Set color of bar graphs
    bar_color_map(1,:) = [.2 .71 .3];  % Green Color for segment 1.
    bar_color_map(2,:) = [.25 .55 .79];  % Blue Color for segment 2.
    bar_color_map(3,:) = [.9 .1 .14];  % Red Color for segment 3.
    bar_color_map(4,:) = [.9 .9 .14];  % Yellow color
    bar_color_map(5,:) = [.3 .71 .3];
    bar_color_map(6,:) = [.35 .44 .79];
    bar_color_map(7,:) = [.6 .15 .49];
    bar_color_map(8,:) = [.8 .12 .54];
    
    %Plot bar graph
    acc_mean_bar_series(jj) = bar(jj,kin_exp_acc(jj));
%     bar(kin_exp_acc,'FaceColor', bar_color_map(jj,:));
    legend(kin_labels,'Location','northwest')
    hold on;
    xlabel('Kinematic Chain');
    ylabel('Acc(m/s^2)');
    title('Average Acceleration for ' + string(trial_num)+ ' Trials Along Kinematic Chain')
end










