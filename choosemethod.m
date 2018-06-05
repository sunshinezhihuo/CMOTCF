%%
% choose method
%%----------------------------------------------------------------------------------------------------------CF

global enableGPU;
switch param.method
    case 'MOSSE'
       
        param.indLayers = 0;
        param.interp_factor = 0.075;  %linear interpolation factor for adaptation

        param.kernel.type = 'linear';
        param.kernel.sigma = 0.2;  %gaussian kernel bandwidth

        param.kernel.poly_a = 1;  %polynomial kernel additive term
        param.kernel.poly_b = 7;  %polynomial kernel exponent

        % features
        param.features.gray = true;  % true
        param.features.hog = false;  % false
        param.features.hog_orientations = 9;
        param.cell_size = 1;   % must = 1  hog=> can =4

        param.obs_thr = 0.35;    %0.45  % Threshold for local and global association      (less than pair .cost)
        param.type_thr = 0.4;   %0.57 % Threshold for changing a tracklet type (conf(T),not significantly affected in author's paper)
        %%
        % common
        param.padding = 3;  %extra area surrounding the target

        param.lambda = 1e-4;  %regularization
        param.output_sigma_factor = 0.1;

        param.target_sz = [100,41];
        param.window_sz = [120,60];
%-------------------------------
        output_sigma = sqrt(prod(param.target_sz)) * param.output_sigma_factor / param.cell_size;
        param.yf = fft2(gaussian_shaped_labels(output_sigma, floor(param.window_sz / param.cell_size)));

        %store pre-computed cosine window
        param.cos_window = hann(size(param.yf,1)) * hann(size(param.yf,2))';	


    case 'KCF'
      
        param.indLayers = 0;
        param.interp_factor = 0.02;

        param.kernel.type = 'linear';    %'linear'; % gaussian
        param.kernel.sigma = 0.5;

        param.kernel.poly_a = 1;
        param.kernel.poly_b = 9;
        
        % features
        param.features.hog = true;      %true
        param.features.gray = false;    %false
        param.features.hog_orientations = 9;

        param.cell_size = 4;   % 4

        param.obs_thr = 0.28;            % Threshold for local and global association 0.3
        param.type_thr = 0.35;            % Threshold for changing a tracklet type 0.37
        
        %%
        % common
        param.padding = 3;  %extra area surrounding the target

        param.lambda = 1e-4;  %regularization
        param.output_sigma_factor = 0.1; %0.1

        param.target_sz = [100,41];
        param.window_sz = [120,60];
%------------------------
        output_sigma = sqrt(prod(param.target_sz)) * param.output_sigma_factor / param.cell_size;
        param.yf = fft2(gaussian_shaped_labels(output_sigma, floor(param.window_sz / param.cell_size)));

        %store pre-computed cosine window
        param.cos_window = hann(size(param.yf,1)) * hann(size(param.yf,2))';	
     

    case 'HCF'
%         %%

        mex -setup;
        enableGPU = true; % false
        
        vl_compilenn('enableGpu',true);
        vl_setupnn();

        param.interp_factor = 0.01;  %linear interpolation factor for adaptation
        
        param.kernel.type = 'linear';
        param.kernel.poly_a = 2;  %no use
        param.kernel.poly_b = 7;  %no use

        param.features.gray = false;            %no use
        param.features.hog = false;             %no use
        param.features.hog_orientations = 9;    %no use
        param.features.deep = true;

        param.cell_size = 4;
       
        param.obs_thr = 0.3;    %0.3       % Threshold for local and global association,0.32508
        param.type_thr = 0.62;    %0.57  0.621     % Threshold for changing a tracklet type  conf(T) 0.3
        %% common      
%         param.padding = 3;
        param.padding = struct('generic', 1.8, 'large', 1, 'height', 0.4);
        param.lambda = 1e-4;  %regularization
        param.output_sigma_factor = 0.1;   % spatial bandwidth for the Gaussian label

        % Here ,we don't change the size.!=HCF BUT error
        param.target_sz = [100,41];
        param.window_sz = [120,60];             
%------------------------------------------------------------
        output_sigma = sqrt(prod(param.target_sz)) * param.output_sigma_factor / param.cell_size;
        param.l1_patch_num = floor(param.window_sz / param.cell_size);
        param.yf = fft2(gaussian_shaped_labels(output_sigma, param.l1_patch_num));
        param.cos_window = hann(size(param.yf,1)) * hann(size(param.yf,2))';	
% ----new----

%         param.indLayers = [37, 28, 19];   % The CNN layers Conv5-4, [35, 26, 17]
%         Conv4-4, and Conv3-4 in VGG Net, in fact pool5, pool4, pool3
        
        param.indLayers = [37, 28, 19];    %[37, 28, 19]
        param.nweights1  = [1, 0.5, 0.02]; % Weights for combining correlation filter responses[1, 0.5, 0.02]
        param.numLayers = length(param.indLayers);
        
        param.nweights  = reshape(param.nweights1,1,1,[]);
    otherwise
        error('Unknown method.')
end
%%----------------------------------------------------------------------------------------------------------CF

