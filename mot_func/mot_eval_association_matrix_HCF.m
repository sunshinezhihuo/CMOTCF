function [score_mat] = mot_eval_association_matrix_HCF(Refer,Test,param,type,method)
%% Copyright (C) 2014 Seung-Hwan Bae
%% All rights reserved.


% Association score matrix
score_mat =zeros(length(Refer),length(Test));
for i=1:length(Refer)
    
%     refer_hist = Refer(i).hist(:)/sum(Refer(i).hist(:));
    refer_h = Refer(i).h;
    refer_w = Refer(i).w;
    
    
    for j=1:length(Test)
% ----------------------------------------------------------------------------------------------CF
        % Appearance affinity
        if isfield(Test(j),'zf')
            zf = Test(j).zf;
        else
            zf = Test(j).model_xf;
        end
        
        switch method
%=================================================================================================================
        case 'HCF',
        %predictPosition
        % Compute correlation filter responses at each layer
        res_layer = zeros([param.l1_patch_num, length(param.indLayers)]);
        
        % feat = 
        
        for ii = 1 : length(param.indLayers)
            
            zlf = zf{ii};
            kzf=sum(zlf .* conj(Refer(i).model_xf{ii}), 3) / numel(zlf);
    
            temp = real(fftshift(ifft2(Refer(i).model_alphaf{ii} .* kzf)));
            res_layer(:,:,ii) = temp/max(temp(:));
            
%             res_layer(:,:,ii) = real(fftshift(ifft2(Refer(i).model_alphaf{ii} .* kzf)));
                      %%equation for fast detection, old is error!!!!
        end

        % Combine responses from multiple layers (see Eqn. 5)
        response = sum(bsxfun(@times, res_layer, param.nweights), 3);
       
        maxresponse = max(response(:));
        app_sim = maxresponse;    

            
%==============================================================================================================//
        case 'MOSSE',
        switch param.kernel.type
        case 'gaussian',
            kzf = gaussian_correlation(zf, Refer(i).model_xf, param.kernel.sigma);
        case 'polynomial',
            kzf = polynomial_correlation(zf, Refer(i).model_xf, param.kernel.poly_a, param.kernel.poly_b);
        case 'linear',
            kzf = linear_correlation(zf, Refer(i).model_xf);
        end
        response = real(ifft2(Refer(i).model_alphaf .* kzf));  %equation for fast detection
        [maxresponse,psr]=PSR_CF(response,0.15);
        
        app_sim = maxresponse;
        
        case 'KCF',
        switch param.kernel.type
        case 'gaussian',
            kzf = gaussian_correlation(zf, Refer(i).model_xf, param.kernel.sigma);
        case 'polynomial',
            kzf = polynomial_correlation(zf, Refer(i).model_xf, param.kernel.poly_a, param.kernel.poly_b);
        case 'linear',
            kzf = linear_correlation(zf, Refer(i).model_xf);
        end
        response = real(ifft2(Refer(i).model_alphaf .* kzf));  %equation for fast detection
        [maxresponse,psr]=PSR_CF(response,0.15);
        
        app_sim = maxresponse;    
        end
% ----------------------------------------------------------------------------------------------CF//
        % Motion affinity
        [mot_sim] =  mot_motion_similarity(Refer(i), Test(j), param, type);
        
        % Shape affinity
        test_h = Test(j).h;
        test_w = Test(j).w;
        shp_sim = mot_shape_similarity(refer_h, refer_w, test_h, test_w);
        
        
        score_mat(i,j) = mot_sim*app_sim*shp_sim;
    
end

end


