function  q_img  = Uniquantization( img, quantizer_bits, input_bits )
if ( quantizer_bits < input_bits )
    img_double = double(img);
    minval = min(img_double(:));
    maxval = max(img_double(:)) + 10^(-8);  % the arbitrary added value 10^(-8) ensures that max(img_double(:)) is strictly inside the last interval
    delta = (maxval-minval)/(2^quantizer_bits);
    q_img = minval + delta*(floor((img_double-minval)/delta)+0.5);
else
    q_img = img;
end

end

