function [Trk, param] = mot_tracklets_components_setup_HCF(img,Trk,detections,cfr,y_idx,param,tmp_label)
%% Copyright (C) 2014 Seung-Hwan Bae
%% All rights reserved.

noft = length(Trk)+1;
ass_idx = y_idx;
nofa = length(find(y_idx ~= 0));

Trk(noft).Conf_prob = param.init_prob;

Trk(noft).type = 'High';
Trk(noft).reliable = 'False';
Trk(noft).isnew = 1;
Trk(noft).sub_img = [];
Trk(noft).status = 'none';

if ~isempty(tmp_label)
    Trk(noft).label = tmp_label;
else
    [param,idx] = Labelling(param);
    Trk(noft).label = idx;
end

Trk(noft).ifr = cfr -nofa + 1;
Trk(noft).efr = 0;
Trk(noft).last_update = cfr;

%--------------------------------------------------------------------------------------------------CF
if param.features.hog,
    model_xf_sum = zeros(param.window_sz(1)/param.cell_size,param.window_sz(2)/param.cell_size,31);
    model_alphaf_sum = zeros(param.window_sz(1)/param.cell_size,param.window_sz(2)/param.cell_size);
    %--------------------------------------------------------------------------------------------------CF//
for i=1:nofa
    tmp_idx = cfr-i+1;
    Trk(noft).state{tmp_idx}(1,1) = detections(tmp_idx).x(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(2,1) = detections(tmp_idx).y(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(3,1) = detections(tmp_idx).w(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(4,1) = detections(tmp_idx).h(ass_idx(tmp_idx)); 
%--------------------------------------------------------------------------------------------------CF    
    %extract model_alphaf and model_xf
    %create regression labels, gaussian shaped, with a bandwidth
	%proportional to target size
	
    %obtain a subwindow for training at newly estimated target position
    patch = get_subwindow_HCF(img{tmp_idx},Trk(noft).state{tmp_idx},param.target_sz,param.window_sz);
    patch = rgb2gray(patch);
    xf = fft2(get_features_HCF(patch, param.features, param.cell_size, param.cos_window, param.indLayers));

    %Kernel Ridge Regression, calculate alphas (in Fourier domain)
    switch param.kernel.type
    case 'gaussian',
        kf = gaussian_correlation(xf, xf, param.kernel.sigma);
    case 'polynomial',
        kf = polynomial_correlation(xf, xf, param.kernel.poly_a, kernel.poly_b);
    case 'linear',
        kf = linear_correlation(xf, xf);
    end
    alphaf = param.yf ./ (kf + param.lambda);   %equation for fast training
    model_alphaf_sum = model_alphaf_sum+alphaf;
    model_xf_sum = model_xf_sum+xf;
end
% Appearnce Model
Trk(noft).model_alphaf = model_alphaf_sum./nofa;
Trk(noft).model_xf = model_xf_sum./nofa;
%--------------------------------------------------------------------------------------------------CF//
elseif param.features.gray,
    model_xf_sum = zeros(param.window_sz(1),param.window_sz(2));
    model_alphaf_sum = zeros(param.window_sz(1)/param.cell_size,param.window_sz(2)/param.cell_size);
    %--------------------------------------------------------------------------------------------------CF//
for i=1:nofa
    tmp_idx = cfr-i+1;
    Trk(noft).state{tmp_idx}(1,1) = detections(tmp_idx).x(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(2,1) = detections(tmp_idx).y(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(3,1) = detections(tmp_idx).w(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(4,1) = detections(tmp_idx).h(ass_idx(tmp_idx)); 
%--------------------------------------------------------------------------------------------------CF    
    %extract model_alphaf and model_xf
    %create regression labels, gaussian shaped, with a bandwidth
	%proportional to target size
	
    %obtain a subwindow for training at newly estimated target position
    patch = get_subwindow_HCF(img{tmp_idx},Trk(noft).state{tmp_idx},param.target_sz,param.window_sz);
    patch = rgb2gray(patch);
    xf = fft2(get_features_HCF(patch, param.features, param.cell_size, param.cos_window, param.indLayers));

    %Kernel Ridge Regression, calculate alphas (in Fourier domain)
    switch param.kernel.type
    case 'gaussian',
        kf = gaussian_correlation(xf, xf, param.kernel.sigma);
    case 'polynomial',
        kf = polynomial_correlation(xf, xf, param.kernel.poly_a, kernel.poly_b);
    case 'linear',
        kf = linear_correlation(xf, xf);
    end
    alphaf = param.yf ./ (kf + param.lambda);   %equation for fast training


    model_alphaf_sum = model_alphaf_sum+alphaf;
    model_xf_sum = model_xf_sum+xf;
end


% Appearnce Model
Trk(noft).model_alphaf = model_alphaf_sum./nofa;
Trk(noft).model_xf = model_xf_sum./nofa;
%--------------------------------------------------------------------------------------------------CF//
else
%HCF---features----cnn---------------------------------------------------------------------------------------~HCF
%===========================================================================================================
    model_xf_sum = cell(1, param.numLayers);
    model_alphaf_sum = cell(1, param.numLayers);
%     

    %--------------------------------------------------------------------------------------------------CF//
for i=1:nofa
    tmp_idx = cfr-i+1;
    Trk(noft).state{tmp_idx}(1,1) = detections(tmp_idx).x(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(2,1) = detections(tmp_idx).y(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(3,1) = detections(tmp_idx).w(ass_idx(tmp_idx)); 
    Trk(noft).state{tmp_idx}(4,1) = detections(tmp_idx).h(ass_idx(tmp_idx)); 
%--------------------------------------------------------------------------------------------------CF    
    %extract model_alphaf and model_xf
    %create regression labels, gaussian shaped, with a bandwidth
	%proportional to target size
	
    %obtain a subwindow for training at newly estimated target position
    
%     bbox = Trk(noft).state{tmp_idx};
%     w_scale = param.window_sz(2)/param.target_sz(2);
%     h_scale = param.window_sz(1)/param.target_sz(1);
%     sz(2)=bbox(3)*w_scale;
%     sz(1)=bbox(4)*h_scale;
%     pos=bbox([2,1]);    
    
   patch = get_subwindow_HCF(img{tmp_idx},Trk(noft).state{tmp_idx},param.target_sz,param.window_sz);
   patch = rgb2gray(patch);
   feat = get_features_HCF(patch, param.features, param.cell_size, param.cos_window, param.indLayers);
    
%    feat  = extractFeature(img{tmp_idx}, pos, param.window_sz, param.cos_window, param.indLayers);
   
   
   numLayers = length(feat);
    for ii=1 : numLayers
        xf{ii} = fft2(feat{ii});        % only for every element
        kf = sum(xf{ii} .* conj(xf{ii}), 3) / numel(xf{ii});
        alphaf{ii} = param.yf./ (kf+ param.lambda);   % Fast training
    end
    
    
    
    % for structure being same
    if i==1
         for ii=1 :numLayers
         model_alphaf_sum{ii} = alphaf{ii};  
         model_xf_sum{ii} = xf{ii};           
         end
         for m=1 :numLayers
         model_alphaf_sum{m} = model_alphaf_sum{m} - model_alphaf_sum{m};  
         model_xf_sum{m} = model_xf_sum{m} - model_xf_sum{m};           
         end
                 
    end
        
     for jj=1 :numLayers
     
         model_alphaf_sum{jj} = model_alphaf_sum{jj}+alphaf{jj};  
         model_xf_sum{jj} = model_xf_sum{jj}+xf{jj};  
     end         
    
end

% Appearnce Model
for kk=1 : numLayers
    Trk(noft).model_alphaf{kk} = model_alphaf_sum{kk}./nofa;
    Trk(noft).model_xf{kk} = model_xf_sum{kk}./nofa;
end

%=============================================================================================================//
end %//end all if cases

% Forward Motion Model
[XX,PP] = mot_motion_model_generation(Trk(noft),param,'Forward');

lt = size(XX,2);
Trk(noft).FMotion.X(:,cfr-lt+1 :cfr) = XX;
Trk(noft).FMotion.P(:,:,cfr-lt+1 :cfr) = PP;


Trk(noft).BMotion.X = [];
Trk(noft).BMotion.P = [];

Trk(noft).hyp.score(cfr) = 0;
Trk(noft).hyp.ystate{cfr} = [];



end