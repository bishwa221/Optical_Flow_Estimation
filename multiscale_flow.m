function [u,v] = multiscale_flow(I1,I2)
    % The number of pyramid levels will be determined by the image size
    % At the highest pyramid level the smallest image dimension will be around 
    % 30 pixels.
    lmax = round(log2(min(size(I1))/30));
    % The pyramidal approach can be implemented with a recursive strategy
    [u,v] = multiscale_aux(I1,I2,1,lmax);
end