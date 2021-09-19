% 1D Arrays %
## A = [1,2,3,4] % rows
## A = [1;2;3;4] % columns

% Plotting
##phi = linspace(0,2*pi,10);
##y = sin(phi);
##plot(phi,y);
##
##phi = linspace(0,2*pi,10);
##y = sin(phi);
##stem(phi,y);

% 2D Arrays %
##A = [1 2 3 ; 4 5 6; 7 8 9]
##imagesc(A); colorbar

% Linspace 
##xa = linspace(0,10,10);

% Direct array
##Nx = 10;
##dx = 1;
##xa = [0:Nx-1]*dx;

##Nx = 10
##Ny = 10 
###A = zeros(Nx,Ny)
##
####or 
####
####A = ones(Nx,Ny)
##
##xa = linspace(-1,1,Nx);
##ya = linspace(-1,1,Ny);
##[X, Y] = meshgrid(xa,ya);
##% or 
##[Y, X] = meshgrid(ya,xa);
##A = (X.^2 + Y.^2)<=0.75;
##
##A = zeros(Nx, Ny);
##nx1 = 3
##nx2 = 6
##ny1 = 4
##ny2 = 8
##A(nx1:nx2,ny1:ny2) = 1
##A' % so axis is in the form A[x,y]


% Create a 2D Rectangle grid

% Physical dimensions
##Sx = 1
##Sy = 1
##Nx = 10;
##Ny = 10;
##
##% Rectangle size
##wx = 0.2;
##wy = 0.6;


##% Position indices
##dx = Sx/Nx;
##nx = round(wx/dx);
##nx1  = 1 + floor((Nx - nx)/2);
##nx2 = nx1 + nx - 1;
##
##dy = Sy/Ny;
##ny = round(wy/dy);
##ny1 = 1 + round((Ny - ny)/2);
##ny2 = ny1 + ny - 1;

##% Create Rectangle
##A = zeros(Nx,Ny);
##A(nx1:nx2, ny1:ny2) = 1
##A'

% Create a 2D Circular grid

% Physical dimensions
Sx = 1
Sy = 1
Nx = 10;
Ny = 10;

% Grid arrays
dx = Sx/Nx;
xa = [0:Nx-1]*dx
xa = xa - mean(xa);

dy = Sy/Ny;
ya = [0:Ny-1]*dy;
ya = ya - mean(ya);

% Create circle
r = 0.4;
[Y,X] = meshgrid(ya,xa);
A = (X.^2 + Y.^2) <= r^2

% Create a 2D Elipses

% Physical dimensions
Sx = 1
Sy = 1
Nx = 20;
Ny = 20;

% Grid arrays
dx = Sx/Nx;
xa = [0:Nx-1]*dx
xa = xa - mean(xa);

dy = Sy/Ny;
ya = [0:Ny-1]*dy;
ya = ya - mean(ya);

% Create ellipse
rx = 0.35
ry = 0.45
[Y,X] = meshgrid(ya,xa);
A = ((X/rx).^2 + (Y/ry).^2) <= 1 % eq of circicle scaled to rx and ry radii values
A'

% Create shifted ellipse
xc = -0.15
yc = +0.25
rx = 0.4;
ry = 0.2
[Y,X] = meshgrid(ya,xa);
A = (((X - xc)/rx).^2+((Y - yc)/ry).^2) <= 1 % eq of circicle scaled to rx and ry radii values
A'

% Formed Half-spaces

% Physical dimensions
Sx = 1
Sy = 1
Nx = 20;
Ny = 20;

% Grid arrays
dx = Sx/Nx;
xa = [0:Nx-1]*dx
xa = xa - mean(xa);

dy = Sy/Ny;
ya = [0:Ny-1]*dy;
ya = ya - mean(ya);

% Calculate surface
y = 0.2 + 0.1*cos(4*pi*xa/Sx);

% Fill half space
A = zeros(Nx,Ny);
for nx = 1 : Nx
      ny = round((y(nx) + Sy/2)/dy);
      A(nx,1:ny) = 1
end
A'

% locate either half of a line

% Physical dimensions
Sx = 1
Sy = 1
Nx = 20;
Ny = 20;

% Grid arrays
dx = Sx/Nx;
xa = [0:Nx-1]*dx
xa = xa - mean(xa);

dy = Sy/Ny;
ya = [0:Ny-1]*dy;
ya = ya - mean(ya);
[Y,X] = meshgrid(ya,xa);

x1 = -0.5;
y1 = +0.25;
x2 = +0.50
y2 = -0.25;

m = (y2-y1)/(x2-x1)
A = (Y -y1) - m *(X-x1) > 0
A'

% Masking and Boolean operations

% Physical dimensions
Sx = 1
Sy = 1
Nx = 20;
Ny = 20;

% Grid arrays
dx = Sx/Nx;
xa = [0:Nx-1]*dx
xa = xa - mean(xa);

dy = Sy/Ny;
ya = [0:Ny-1]*dy;
ya = ya - mean(ya);
[Y,X] = meshgrid(ya,xa);

% Formed surface
y = -0.2 + 0.1*cos(4*pi*xa/Sx)
FS = zeros(Nx,Ny);
dy = Sy/Ny;
for nx = 1 : Nx
      ny = round((y(nx) + Sy/2)/dy);
      FS(nx,ny:Ny) = 1
end

% Create a linear half space
x1 = -0.5;
y1 = +0.5;
x2 = +0.5;
y2 = -0.5;
m = (y2 - y1)/(x2-x1);
LHS = (Y-y1) - m * (X-x1)  > 0

A = FS .* LHS

er1 = 1.0
er2 = 2.4;
A = er1*(1-A) + er2*A
%A = er1 + (er2 -er1)*A
  






