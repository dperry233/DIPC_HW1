close all;
clear all;
clc;

%initialization
pic=imread('images.jpg');
pic=rgb2gray(pic);
mse = zeros(8,1);
minval = min(double(pic(:)));
maxval = max(double(pic(:))) + 10^(-8);

%calculate optimization for 1 to 8 bits
for i=1:1:8
    [mse(i),D,R] = Max_Lloyd(pic, i, 8);
    
    %print decision levels and representation levels in 1D graph
    screenSize = get( 0, 'ScreenSize' );
    screen_height = screenSize(4);
    screen_width = screenSize(3);
    width = screen_width * 0.5;
    left = floor( (screen_width - width) / 2 );
    height = 170;
    bottom = floor( (screen_height - height) / 2 );
    figure( 'Position', [ left bottom width height] );
    delta = (maxval-minval)/(2^i);
    z = zeros( numel(D) );
    w=zeros( numel(R));
    
    %calcule width of dots
    if i <= 3
        width = 3;
        if i == 1
            width = 5;
        end
    else
        width = 1;
    end

    plot( D, z, 'r+', 'MarkerSize', numel(D), 'LineWidth', width ); 
    hold on;
    plot( R, w, 'b+', 'MarkerSize', numel(D)-1, 'LineWidth', width );    
    set( gca, 'YTick', -1:1:1 );
    set( gca, 'YTickLabel', {'','',''} );
    hold on;
    xlimits = xlim;
    plot( xlimits, [ 0 0 ], 'Color', 'black' );
    grid on;
    
  % add titles  
    txt = ['Decision and Representation level,  b = ',num2str(i)];
    title(txt);
    text(255.5,.2,'Representation levels','Color','blue','FontSize',11, 'FontWeight', 'bold');
    text(255.5,.1,'Decision levels','Color','red','FontSize',11, 'FontWeight', 'bold');
end
hold off;
figure;
x=1:1:8;


plot(x, mse);
title('MSE Using Max Lloyd');
xlabel('Bit number')
ylabel('MSE')
figure

%compare Max Lloyd optimization to Uniquantizer
for i=1:1:8
    curr_pic = Uniquantization(pic, i, 8);
    y(i) = mse_clc(pic, curr_pic);
end
plot(x, y,x, mse);
title('MSE Using Max Lloyd and Uniform Quantizier');
xlabel('Bit number')
ylabel('MSE')
legend('Uniform','Max Lloyd')
