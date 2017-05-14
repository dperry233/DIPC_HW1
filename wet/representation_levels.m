function [ R ] = representation_levels( img, D )
    %initialization
    histo = imhist(img);
    d_img = double(img);
    R = zeros(1,numel(D)-1);
    
    %calcule representation levels according to represantation levels
    for i = 1:numel(D)-1
        low = ceil(D(i));
        high = ceil(D(i+1));
        tmp_h=zeros(high-low,1);
        % cut histogram to be only what is relevant for the current
        % interval
        for j=1:1:high-low
            tmp_h(j)=histo(low+j);
        end
        B = low:1:high-1;
        B=transpose(B);
        %calculate center of mass
        my_sum = sum((tmp_h).*double(B))/numel(img);
        probability = sum(tmp_h)/numel(img);
        R(i)= my_sum/probability;
    end

end

