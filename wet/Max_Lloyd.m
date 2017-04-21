function [ mse, D, R ] = Max_Lloyd( img, quantizer_bits, input_bits )
    if quantizer_bits < input_bits
        %initialize
        d_img = double(img);
        minval = min(d_img(:));
        maxval = max(d_img(:)) + 10^(-8);
        delta = (maxval-minval)/(2^quantizer_bits);
        D = minval:delta:maxval;
        R = [minval+0.5*delta:delta:maxval-0.5*minval];
        q_img = minval + delta*(floor((d_img-minval)/delta)+0.5);
        mse=mse_clc(d_img, q_img);
        diff = mse;
        % operating Max Lloyd algorithem
        while diff > 0.001
            %level 2, 3 update decitiion levels and representation levels
            R=representation_levels(img, D);
            for i=2:1:numel(D)-1
                D(i)=(R(i-1) + R(i))*0.5;
            end
            % update image
            q_img = zeros(size(d_img, 1), size(d_img, 2));
            double(q_img);
            for i=1:1:numel(D)-1
                tmp = (d_img >= D(i) & d_img < D(i+1));
                tmp = tmp .* R(i);
                q_img = q_img + tmp;
            end
            %update the error
            diff = mse - mse_clc(d_img, q_img);
            mse = mse_clc(d_img, q_img);
        end
    else 
        % halnde the case when there is no need to optimize
        mse = 0;
        D=0:1:256;
        R=0.5:1:256;
    end
end

