
function [Trk, Obs_grap, Obs_info] = MOT_Local_Association_HCF(Trk, detections, Obs_grap, param, fr, rgbimg, method)
%% Copyright (C) 2014 Seung-Hwan Bae
%% All rights reserved.


Z_meas = detections(fr);
ystate = [Z_meas.x, Z_meas.y, Z_meas.w, Z_meas.h]';
Obs_grap(fr).iso_idx = ones(size(detections(fr).x));
Obs_info.ystate = [];
% Obs_info.yhist  =[];

Obs_info.zf=[];               %----------------------------------------------------------------------cf

if ~isempty(ystate)
%     yhist = mot_appearance_model_generation(rgbimg, param, ystate); % feature�� color histogram����.
    Obs_info.ystate = ystate;
%     Obs_info.yhist = yhist;
    
%----------------------------------------------------------------------------------------------------cf
    num_det = size(ystate,2);
   
    zf = cell(num_det,1);
    for i=1:num_det
        switch param.method
        case 'MOSSE',
        patch = get_subwindow_HCF(rgbimg,ystate(:,i),param.target_sz,param.window_sz); %---hcf
        patch = rgb2gray(patch);
        zf{i} = fft2(get_features_HCF(patch, param.features, param.cell_size, param.cos_window)); %---hcf
        case 'KCF',
        patch = get_subwindow_HCF(rgbimg,ystate(:,i),param.target_sz,param.window_sz); %---hcf
        patch = rgb2gray(patch);
        zf{i} = fft2(get_features_HCF(patch, param.features, param.cell_size, param.cos_window)); %---hcf
        case 'HCF',
        bbox = ystate(:,i);
        w_scale = param.window_sz(2)/param.target_sz(2);
        h_scale = param.window_sz(1)/param.target_sz(1);
        sz(2)=bbox(3)*w_scale;
        sz(1)=bbox(4)*h_scale;
        pos=bbox([2,1]);
        
%         bbox = ystate(:,i);
%         w_scale = param.window_sz(2)/param.target_sz(2);
%         h_scale = param.window_sz(1)/param.target_sz(1);
%         sz(2)=bbox(3)*w_scale;
%         sz(1)=bbox(4)*h_scale;
%         pos=bbox([2,1]);
       
%         patch = get_subwindow(rgbimg,pos,sz); %---hcf
        patch = get_subwindow_HCF(rgbimg,ystate(:,i),param.target_sz,param.window_sz); %---hcf
        patch = rgb2gray(patch);
        zf{i} = get_features(patch, param.cos_window, param.indLayers); %---hcf
        
%         zf{i} = extractFeature(rgbimg, pos, param.window_sz, param.cos_window, param.indLayers);
        end
        
    end
	Obs_info.zf=zf;		
%----------------------------------------------------------------------------------------------------cf//
    tidx = Idx2Types(Trk,'High');
    yidx = find(Obs_grap(fr).iso_idx == 1);
    
    
    if ~isempty(tidx) && ~isempty(yidx)
        Trk_high =[]; Z_set =[];
        
        trk_label = [];
        conf_set = [];
        % For tracklet with high confidence / Length, Occlusion, Affinity
        for ii=1:length(tidx)
            i = tidx(ii);
            
            Trk_high(ii).model_alphaf = Trk(i).model_alphaf;%-------------------------cf
            Trk_high(ii).model_xf = Trk(i).model_xf;%------------------------------------cf

            Trk_high(ii).FMotion = Trk(i).FMotion;
            Trk_high(ii).last_update = Trk(i).last_update;
            
            Trk_high(ii).h = Trk(i).state{end}(4);
            Trk_high(ii).w = Trk(i).state{end}(3);
            Trk_high(ii).type = Trk(i).type;
            trk_label(ii) = Trk(i).label;
            conf_set = [conf_set,  Trk(i).Conf_prob];
        end
        
        % For detections
        meas_label = [];
        for jj=1:length(yidx)
            j = yidx(jj);
            Z_set(jj).zf = zf{j};%------------------------------------cf
            Z_set(jj).pos = [ystate(1,j);ystate(2,j)];
            Z_set(jj).h =  ystate(4,j);
            Z_set(jj).w = ystate(3,j);
            meas_label(jj) = j;
        end
        
        thr = param.obs_thr;
        
        
        
        [score_mat] = mot_eval_association_matrix_HCF(Trk_high, Z_set, param, 'Obs', method);  
        % Trk_high: reliable tracklets, Z_set: detection results
        [matching, ~] = mot_association_hungarian(score_mat, thr); % hungarian solver.
        
        
        if ~isempty(matching)
            for i=1:size(matching,1)
                ass_idx_row = matching(i,1);
                ta_idx = tidx(ass_idx_row);
                ass_idx_col = matching(i,2);
                ya_idx = yidx(ass_idx_col);
                Trk(ta_idx).hyp.score(fr) = score_mat(matching(i,1),matching(i,2));
                Trk(ta_idx).hyp.ystate{fr} =  ystate(:,ya_idx);
                Trk(ta_idx).hyp.new_tmpl = zf{ya_idx};%--------------------------------------cf
                Trk(ta_idx).last_update = fr;
                Obs_grap(fr).iso_idx(ya_idx) = 0;
                
            end
        end
    end
end
end