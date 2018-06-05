function [Trk] = MOT_State_Update_HCF(Trk, param, fr)
%% Copyright (C) 2014 Seung-Hwan Bae
%% All rights reserved.
% Update states and models of tracklets

for i=1:length(Trk)
    if Trk(i).last_update == fr
    switch param.method                  
        case 'MOSSE',
             %---------------------------------------------------------------------------------cf
        new_model_xf = Trk(i).hyp.new_tmpl;
        old_model_alphaf = Trk(i).model_alphaf;
        old_model_xf = Trk(i).model_xf;
        
        xf = new_model_xf;

		%Kernel Ridge Regression, calculate alphas (in Fourier domain)
		switch param.kernel.type
		case 'gaussian',
			kf = gaussian_correlation(xf, xf, param.kernel.sigma);
		case 'polynomial',
			kf = polynomial_correlation(xf, xf, param.kernel.poly_a, param.kernel.poly_b);
		case 'linear',
			kf = linear_correlation(xf, xf);
		end
		alphaf = param.yf ./ (kf + param.lambda);   %equation for fast training


        %subsequent frames, interpolate model
        Trk(i).model_alphaf = (1 - param.interp_factor) * old_model_alphaf + param.interp_factor * alphaf;
        Trk(i).model_xf = (1 - param.interp_factor) * old_model_xf + param.interp_factor * xf;
        
        
   
        case 'KCF',
             %---------------------------------------------------------------------------------cf
        new_model_xf = Trk(i).hyp.new_tmpl;
        old_model_alphaf = Trk(i).model_alphaf;
        old_model_xf = Trk(i).model_xf;
        
        xf = new_model_xf;

		%Kernel Ridge Regression, calculate alphas (in Fourier domain)
		switch param.kernel.type
		case 'gaussian',
			kf = gaussian_correlation(xf, xf, param.kernel.sigma);
		case 'polynomial',
			kf = polynomial_correlation(xf, xf, param.kernel.poly_a, param.kernel.poly_b);
		case 'linear',
			kf = linear_correlation(xf, xf);
		end
		alphaf = param.yf ./ (kf + param.lambda);   %equation for fast training


        %subsequent frames, interpolate model
        Trk(i).model_alphaf = (1 - param.interp_factor) * old_model_alphaf + param.interp_factor * alphaf;
        Trk(i).model_xf = (1 - param.interp_factor) * old_model_xf + param.interp_factor * xf;
        
        case 'HCF',
        
        % Initialization
        new_model_xf = Trk(i).hyp.new_tmpl;
        old_model_alphaf = Trk(i).model_alphaf;
        old_model_xf = Trk(i).model_xf;
              
        xfeat = new_model_xf;      %me add
        numLayers = length(xfeat);  %me add
        
        xf       = cell(1, numLayers); %me add
        alphaf   = cell(1, numLayers); %me add
        
        for ii=1 : numLayers
            xf{ii} = fft2(xfeat{ii});   %me add
            kf = sum(xf{ii} .* conj(xf{ii}), 3) / numel(xf{ii});
            alphaf{ii} = param.yf./ (kf+ param.lambda);   % Fast training
        end

% Model initialization or update

    % Online model update using learning rate interp_factor
        for ii=1:numLayers       	
        %subsequent frames, interpolate model
            Trk(i).model_alphaf{ii} = (1 - param.interp_factor) * old_model_alphaf{ii} + param.interp_factor * alphaf{ii};
            Trk(i).model_xf{ii} = (1 - param.interp_factor) * old_model_xf{ii} + param.interp_factor * xf{ii};
        end
        
        
 %---------------------------------------------------------------------------------cf//    
    end
        ystate = Trk(i).hyp.ystate{fr};
        [Trk(i)] = km_state_update(Trk(i),ystate,param,fr);
        
    else
        [Trk(i)]= km_state_update(Trk(i), [], param,fr);
    end
end
end
