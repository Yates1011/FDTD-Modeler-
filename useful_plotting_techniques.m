'''simple plotting techniques for the FDTD project'''

% How to create subplots %
## subplot(M,N,p) 
## where M = rows, n = columns and p = pos
## subplot(2,3,5)

% Non-uniform partitioning %
## x = linspace(-1,1,100);
## y1 = x;
## y2 = x.^2;
## y3 = exp(-x.^2);
##
## subplot(2,2,1);
## plot(x,y1);
##
## subplot(2,2,2);
## plot(x,y1);
##
## subplot(2,2,[3:4]);  % plots from pos[3:4]
## plot(x,y3);


% 1D plot %
## x = linspace(-1,1,100);
## y = x.^2; % point by point
## plot(x,y);
## figure('Color','w')
## h = plot(x,y,'-b','LineWidth',2);
## h2 = get(h,'Parent');
## set(h2,'Fontsize',14,'LineWidth',2);
## xlabel('x')
## ylabel('y','Rotation',0);
## title('Plot')

% Set tick markings %
##xm = [-1:0.5:+1];
##xt = {};
##for m = 1: length(xm)
##  xt{m} = num2str(xm(m),'%3.2f');
## end
## set(h2,'XTick',xm,'XTIck:abel', xt);
## 
##ym = [0:0.1:+1];
##yt = {};
##for m = 1: length(ym)
##  yt{m} = num2str(ym(m),'%2.1f');
## end
## set(h2,'YTick',ym,'YTIck:abel', yt);


% Axis limits and annotation %
## xlim([-2 2])
## text(h_pos, v_pos,text)
## ylim([-0.5 1.5])



% Multiple lines%
## x = linspace(-1,1,100);
## y1 = x.^1
## y2 = x.^2
## y3 = x.^3

##plot(x,y1,'-r',LineWidth',2);
##hold on;
##plot(x,y2,'-g',LineWidth',2);
##plot(x,y3,'-b',LineWidth',2);
##hold off;

% Data points %
##x = linspace(-1,1,100);
##y = x.^2; % point by point
##fig = figure('Color','w');
##plot(x,y,'o-r','LineWidth',2);

% 2D Graphics %
% Mesh
##xa = linspace(-2,2,50);
##ya = linspace(-1,1,25);
##[Y,X] = meshgrid(ya,xa);
##
##D = X.^2 + Y.^2;
##imagesc(xa,ya,D'); displays a 2D array as an image
##pcolor(xa,ya,D);

% Surf
##surf(xa,ya,D');

% optional
##shading interp; % good for publications or presentations 
##axis equal 
##or 
##axis equal tight;
##camlight; lighting phong;
##view(25,45); % azimuth and elevation angles

% Custom colourmap 
##CMAP = zeros(256,3);
##c1 = [0 0 1]; % blue
##c2 = [1 1 1]; % white 
##c3 = [1 0 0]; % red
##for nc = 1 : 128
##      f = (nc - 1)/128;
##      c = (1 - sqrt(f))*c1 + sqrt(f)*c2;
##      CMAP(nc, :) = c;
##      c = (1 - f^2)*c2 + f^2*c3);
##      CMAP(128+nc,:) = c;
##end
##
##colormap(CMAP);

% Fill
## fill(x,y,c) % shape we want to fill in

##% Rectangle
##x = [0 1 1 0 0];
##y = [0 0 1 1 0];
##fill(x,y,'r');
##axis([-0.5 1.5 -0.5 1.5]);

% Circle
##phi = linspace(0,2*pi,200);
##x = cos(phi);
##y = sin(phi);
##fill(x,y,'g');
##axis([-1 +1 -1 +1]);
##axis equal;

% Creating short movies (MATLAB only) %

##movie_name = 'example.avi';
##vidObj = VideoWriter(movie_name);
##% Draw frame
##clf; % or close all
##drawnow;
##% Add frame to AVI
##F = getframe(fig)
##writeVideo(vidObj,F);
##
##close(vidObj);
##F = getframe(fig);
##or
##F = getframe(gcf) % get current figure
##
##subplot(???);
##F = getframe(gca) % get current axis
##
##F = getframe(fig);
##B = frame2im(F);
##imwrite(B, 'dumb_pic.jpg','JPEG');
##
##B = imread('dumb_pic.jpg','JPEG');
##F = im2frame(B);
##writeVideo(vidObj,F);

% Miscellaneous functions %

% initialise Octave/MATLAB
##close all; % closes all figure windows
##clc;          % erases command window
##clear all;  % clears all variables from memory

% Initialising arrays
##A = zeros(10,10);
##A = ones(10,10);
##A = rand(10,10);
## A = [1,2,3,4] % rows
## A = [1;2;3;4] % columns

% log() vs log10()

% find()
% Command that returns arrays indices of specific values in an array
##A = [ 1 2 3 4 5 6]
##ind = find(A==3)

% ' vs .'
% ' = Hermitian transpose
% .' = Regular transpose

% Interpolate data

% interp1
##xa1 = linspace(-1,1,21);
##xa2 = linspace(-1,1,250);
##
##f1 = exp(-xa1.^2/0.2^2);
##
##%f2 = interp1(xa1,f1,xa2);
##% or
##f2 = interp1(xa1, f1,xa2,'cubic'); % smooths graph
##
##plot(xa2,f2,'.b'); hold on;
##plot(xa1,f1,'o-r'); hold off;

%interp2
##ER2 = interp2(ya,xa',ER,ya2,xa2);
%interp 3

% Timing code
% Method 1
##tic
##%code to measure
##toc
##% Method 2
##t1 = clock;
##
##% code to measure
##
##t2 = clock;
##t = etime(t2,t1);
##disp(['Elapsed time is',num2str(t),'seconds']);

% FFT and FFTSHIFT
##f = [ zeros(1,500) ones(1,100) zeros(1,500) ];
##F1 = fft(f)/length(f);
##F2 = fftshift(F1);
##
##subplot(3,1,1);
##plot(f);
##hold on;
##subplot(3,1,2);
##plot(F1);
##subplot(3,1,3);
##plot(F2);
##hold(off);

















