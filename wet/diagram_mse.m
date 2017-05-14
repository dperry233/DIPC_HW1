close all;
clear all;
clc;

figure;
x = [1:1:8];
y = [1:1:8];
pic=imread('zebra.jpg');
pic=rgb2gray(pic);

%calculate MSE for uniquantizer
for i=1:1:8
    curr_pic = Uniquantization(pic, i, 8);
    y(i) = mse_clc(pic, curr_pic);
end
% print the MSE's
plot(x,y);
grid on;
title('MSE using b bits');
xlabel('Bit number')
ylabel('MSE')
figure(1)
pic_double = double(pic);
minval = min(pic_double(:));
maxval = max(pic_double(:)) + 10^(-8);

%print represebtation levels and decision levels
for i=[1:1:8]
    delta = (maxval-minval)/(2^i);
    x=[minval:delta:maxval];
    y=[minval+0.5*delta:delta:maxval-0.5*minval]
        screenSize = get( 0, 'ScreenSize' );
    screen_height = screenSize(4);
    screen_width = screenSize(3);
    width = screen_width * 0.5;
    left = floor( (screen_width - width) / 2 );
    height = 170;
    bottom = floor( (screen_height - height) / 2 );
    figure( 'Position', [ left bottom width height] );
    z = zeros( numel(x) );
    w=zeros( numel(y));
    %calculate widths of the dots
    if i <= 3
        width = 3;
        if i == 1
            width = 5;
        end
    else
        width = 1;
    end
    plot( x, z, 'r+', 'MarkerSize', numel(x), 'LineWidth', width ); 
    hold on;
    plot( y, w, 'b+', 'MarkerSize', numel(x)-1, 'LineWidth', width );

    set( gca, 'YTick', -1:1:1 );
    set( gca, 'YTickLabel', {'','',''} );

    hold on;
    xlimits = xlim;
    plot( xlimits, [ 0 0 ], 'Color', 'black' );
    grid on;
    %add titles
    txt = ['Decision and Representation level,  b = ',num2str(i)];
    title(txt);
    text(255,.2,'Representation levels','Color','blue','FontSize',11, 'FontWeight', 'bold');
    text(255,.1,'Decision levels','Color','red','FontSize',11, 'FontWeight', 'bold');
end