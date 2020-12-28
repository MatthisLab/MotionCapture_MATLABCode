function [total_body_COMXYZ] = calc_seg_weight_COM(seg_center,seg_prop_weight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcCOM individual seg contribution to totalCOM
%Prepared based on Miller & Nelson and Lea & Febiger
%Pages 63-64 in David A. Winters book
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
% totalCOMXYZ = [];

%% Head Seg
headCOM =        seg_prop_weight.head_prop .* seg_center.headCenter_mar_dim_frame;
% headCOM =        (bodySegMass.headMass .* segCenter.headCenter_mar_dim_frame);

%% Shoulder Seg
LShoulderCOM =   seg_prop_weight.shoulder_prop .* seg_center.LShoulderCenter_mar_dim_frame;
RShoulderCOM =   seg_prop_weight.shoulder_prop .* seg_center.RShoulderCenter_mar_dim_frame;

% LShoulderCOM =   bodySegMass.shoulderMass .* segCenter.LShoulderCenter_mar_dim_frame;
% RShoulderCOM =   bodySegMass.shoulderMass .* segCenter.RShoulderCenter_mar_dim_frame;

%% Chest Seg
chestCOM =       (seg_prop_weight.chestProp + seg_prop_weight.abdomenProp)...
                    .* seg_center.chestCenter_mar_dim_frame;
%chestCOM =       bodySegMass.chestMass .* segCenter.chestCenter_mar_dim_frame;

%% UpperArm Seg
LUpperArmCOM =   seg_prop_weight.upperArmProp .* seg_center.LUpperArmCenter_mar_dim_frame;
RUpperArmCOM =   seg_prop_weight.upperArmProp .* seg_center.RUpperArmCenter_mar_dim_frame;

% LUpperArmCOM =   bodySegMass.upperArmMass .* segCenter.LUpperArmCenter_mar_dim_frame;
% RUpperArmCOM =   bodySegMass.upperArmMass .* segCenter.RUpperArmCenter_mar_dim_frame;

%% Forearm Seg
LForearmCOM =    seg_prop_weight.forearmProp .* seg_center.LForearmCenter_mar_dim_frame;
RForearmCOM =    seg_prop_weight.forearmProp .* seg_center.RForearmCenter_mar_dim_frame;

% LForearmCOM =    bodySegMass.forearmMass .* segCenter.LForearmCenter_mar_dim_frame;
% RForearmCOM =    bodySegMass.forearmMass .* segCenter.RForearmCenter_mar_dim_frame;

%% Hand Seg
LHandCOM =       seg_prop_weight.handProp .* seg_center.LHandCenter_mar_dim_frame;
RHandCOM =       seg_prop_weight.handProp .* seg_center.RHandCenter_mar_dim_frame;

% LHandCOM =       bodySegMass.handMass .* segCenter.LHandCenter_mar_dim_frame;
% RHandCOM =       bodySegMass.handMass .* segCenter.RHandCenter_mar_dim_frame;

%% Hip Seg
hipCOM =         seg_prop_weight.hipProp .* seg_center.hipCenter_mar_dim_frame;

% hipCOM =          bodySegMass.hipMass .* segCenter.hipCenter_mar_dim_frame;

%% Thigh Seg
LThighCOM =      seg_prop_weight.thighProp .* seg_center.LThighCenter_mar_dim_frame;
RThighCOM =      seg_prop_weight.thighProp .* seg_center.RThighCenter_mar_dim_frame;

% LThighCOM =      bodySegMass.thighMass .* segCenter.LThighCenter_mar_dim_frame;
% RThighCOM =      bodySegMass.thighMass .* segCenter.RThighCenter_mar_dim_frame;

%% Leg Seg
LLegCOM =        seg_prop_weight.legProp .* seg_center.LLegCenter_mar_dim_frame;
RLegCOM =        seg_prop_weight.legProp .* seg_center.RLegCenter_mar_dim_frame;

% LLegCOM =        bodySegMass.legMass .* segCenter.LLegCenter_mar_dim_frame;
% RLegCOM =        bodySegMass.legMass .* segCenter.RLegCenter_mar_dim_frame;

%% Foot Seg
LFootCOM =       seg_prop_weight.footProp .* seg_center.LFootCenter_mar_dim_frame;
RFootCOM =       seg_prop_weight.footProp .* seg_center.RFootCenter_mar_dim_frame;

% LFootCOM =       bodySegMass.footMass .* segCenter.LFootCenter_mar_dim_frame;
% RFootCOM =       bodySegMass.footMass .* segCenter.RFootCenter_mar_dim_frame;

%% Total Center_mar_dim_frame for Body
total_body_COMXYZ = 	(headCOM + LShoulderCOM + RShoulderCOM...
                + chestCOM + LUpperArmCOM + RUpperArmCOM...
                + LForearmCOM + RForearmCOM + LHandCOM ...
                + RHandCOM + hipCOM + LThighCOM + RThighCOM...
                + LLegCOM + RLegCOM + LFootCOM + RFootCOM);

end


