%% Robust Online Multi-Object Tracking based on Tracklet Confidence 
% and Online Discriminative Appearance Learning (CVPR2014)
% Last updated date: 2014. 07. 27
% Copyright (C) 2014 Seung-Hwan Bae
% All rights reserved.
%%
% add path
clc;
clear all;
base = [pwd, '/'];
addpath(genpath(base));

%%
mot_setting_params_HCF;                % setting parameters

%%
disp('Loading detections...');
%% loading detection results 

if ~exist(param.detpath);mkdir(param.detpath);end;

detfilename = strcat(param.detpath,param.yearseq,param.seq,'.mat');
if exist(detfilename,'file')
    delete(detfilename);
end
loadingstddet(param); %change .txt to .mat, perform once is ok
loadcmotdet;
%%
frame_start = 1;
% frame_end depends on detections
if length(img_List) > 10
    frame_end = length(detections);
else
    frame_end = 10;    
end

All_Eval = [];
cct = 0;
Trk = []; 
Trk_sets = []; 
all_mot =[];
%chose a method to track,eg.KCF,MOSSE,HCF
choosemethod;
%% Initiailization Tracklet
tstart1 = tic;
init_frame = frame_start + param.show_scan;

for i=1:init_frame
    Obs_grap(i).iso_idx = ones(size(detections(i).x));
    Obs_grap(i).child = []; 
    Obs_grap(i).iso_child =[];
end

[Obs_grap] = mot_pre_association(detections,Obs_grap,frame_start,init_frame);
st_fr = 1;
en_fr = init_frame;

% loading images (5)
for fr = 1:init_frame
    filename = strcat(img_path,img_List(fr).name);
    rgbimg = imread(filename);
    
        if ismatrix(rgbimg)
            rgbimg = cat(3, rgbimg, rgbimg,rgbimg);
        end
    
    init_img_set{fr} = rgbimg;
end
%%----------------------------------------------------------------------------------------------------CF
% none
[Trk,param,Obs_grap] = MOT_Initialization_Tracklets_HCF(init_img_set,Trk,detections,param,Obs_grap,init_frame);
        
%%----------------------------------------------------------------------------------------------------CF//


%% Tracking 
disp('Tracking objects...');
%% loading images (the rest images)
for fr = init_frame+1:frame_end
    filename = strcat(img_path,img_List(fr).name);
    rgbimg = imread(filename);
    init_img_set{fr} = rgbimg;
    
%%-----------------------------------------------------------------------------------------------------CF
%% NO ILDA
%% Data Association
    % Local Association  
    [Trk, Obs_grap, Obs_info] = MOT_Local_Association_HCF(Trk, detections, Obs_grap, param, fr, rgbimg, param.method);
        
    % Global Association 
    [Trk, Obs_grap] = MOT_Global_Association_HCF(Trk, Obs_grap, Obs_info, param, fr, param.method);
    
%%-----------------------------------------------------lambda2 ??--------------------------------------CF//    
%% Update
%% 
    % Tracklet Confidence Update
    [Trk] = MOT_Confidence_Update(Trk,param,fr, param.lambda2); % equation 2. lambda2
    [Trk] = MOT_Type_Update(rgbimg,Trk,param.type_thr,fr); % What is the type?  
        
    % Tracklet State Update & Tracklet Model Update  .P V S 
    [Trk] = MOT_State_Update_HCF(Trk, param, fr);   % HCF IS ERROR ???????????????????????
    
%%-----------------------------------------------------------------------------------------------------CF
%% none
    %% New Tracklet Generation 
    [Trk, param, Obs_grap] = MOT_Generation_Tracklets_HCF(init_img_set,Trk,detections,param, Obs_grap,fr);
%%-----------------------------------------------------------------------------------------------------CF//
      
%% Tracking Results
    [Trk_sets] = MOT_Tracking_Results(Trk,Trk_sets,fr);
    disp([sprintf('Tracking:Frame_%04d',fr)]);
end

%%
disp('Tracking done...');
TotalTime = toc(tstart1);
AverageTime = TotalTime/(frame_start + frame_end);

%% Draw Tracking Results
% draw img path
out_path = strcat(param.outpath,param.yearseq,'_',param.seq,'/');

DrawOption.isdraw = 1;
DrawOption.iswrite = 1;
DrawOption.new_thr = param.new_thr;

% Box colors indicate the confidences of tracked objects
% High (Red)-> Low (Blue)
%%-----------------------------------------------------------------------------------------------------CF
% method
[all_mot] = MOT_Draw_Tracking_HCF(Trk_sets, out_path, img_path, img_List, DrawOption, param); 
%%-----------------------------------------------------------------------------------------------------CF//
close all;
disp(fprintf('Average running time:%.3f(sec/frame)', AverageTime));
%%
% save tracking results to .mat
savetrackingresults;

%% Evaluate
% .mat==>.txt https://motchallenge.net/instructions/
write_results_to_txt_foreva;   % having param is error! 

%%
%evaluate
evaluate_cem(param);

