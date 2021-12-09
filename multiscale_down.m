function [u,v] = multiscale_down(I1,I2,u,v,l)
    % If the base pyramid level has been reached, return.
    if l == 0
	return
    end
    % Otherwise, upsample the previous flow estimate by a factor of 2 using imresize with 
    % bicubic interpolation. The flow values should be doubled.
    u = 2*imresize(u,2,'bicubic');
    v = 2*imresize(v,2,'bicubic');
    % Warp the input image, I2, according to the upsampled flow estimate.
    I2_ = warp_image(I2,u,v);
    % Estimate the incremental flow update using your estimate_flow function and the warped 
    % input image with 2 as the wsize parameter.
    [u_,v_] = estimate_flow(I2_,u,v);
    % Update the flow estimate by adding the incremental estimate above to the previous estimate.
    u = u+u_;
    v = v+v_;
end