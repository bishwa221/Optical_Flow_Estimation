function [u,v] = multiscale_aux(I1,I2,l,lmax)
    % Downsample the images by half using imresize and bicubic interpolation.
    % Use your gauss_blur function to smooth the result.
    I1_ = gauss_blur(imresize(I1,0.5,'bicubic'));
    I2_ = gauss_blur(imresize(I2,0.5,'bicubic'));
    % If the highest pyramid level has been reached, estimate the optical flow
    % on the downsampled images with your estimate_flow function using 2 as the wsize parameter.
    if l == lmax
    	[u,v] = estimate_flow(I1_,I2_,2);
    % If we are beyond the highest pyramid level, estimate the optical flow
    % on the input images (not the downsampled images) with your estimate_flow function 
    % using 2 as the wsize parameter.
    elseif l > lmax
        l = lmax;
        [u,v] = estimate_flow(I1_,I2_,2);
    % Otherwise, increment the current level and continue up the pyramid (i.e. recurse)
    % using the downsampled images.
    else
        l = l + 1;
	    [u,v] = multiscale_aux(I1_,I2_,l,lmax);
    end
    % After flow has been estimated at the current level, pass this estimate along with
    % the input images (not the downsampled images) to nultiscale_down for iterative 
    % improvement of the flow estimate.
    [u,v] = multiscale_down(I1,I2,u,v,l);
end