% FDTD_Gaussian_source.m
% Basic FDTD Engine with a Gaussian source

% Initialise Matlab/Octave
close all;
clc;
clear all;

% Constants in vacuum 
c0 = 29979458;  % Speed of light
e0 = 8.8541878176e-12; % Permitivity
u0 = 1.2566370614e-6; % Permeability

% Open figure
figure('color', 'w')

%------------------------------------------------------------------------------%
% Source parameters
fmax = 1.5 * 10e9 % 1.5GHz

% Grid 
nmax = 1; % Maximum refraction index 
nlam = 10; % Grid resolution (number of wavelengths)
nbuffer = [100 100]; % Buffer 100 points before and after each point
%% Resolution parameters 

lambda = c0/fmax;
dz = lambda/nmax/nlam

%% Grid size 
nz_grid = sum(nbuffer) + 3; % Number of points on the grid 

%% Griz axis
za = [0:nz_grid-1] * dz

%% Construct device on grid %%
% Initialise material to free space
ER = ones(1, nz_grid);% Relative permeability 
UR = ones(1, nz_grid);% Relative permitivity

% Time step
nbc = sqrt((1)*ER(1));
dt = nbc*dz/(2*c0) % Produce a cell every two time steps 

% Calculate source parameters
tau = 0.5/fmax;
t0 = 5*tau

% Calculate number of time steps
ts = (nmax*nz_grid*dz)/c0
t = 2*t0 + 3*ts % Include each axis
STEPS = ceil(t/dt);

% Calculate source 
t = [0:STEPS-1]*dt;
nz_src = round(nz_grid/2); % Source position
e_src = exp(-((t-t0)/tau).^2);

%% Initialise FDTD parameters %%

% Compute update coefficients
mEy = (c0*dt)./ER; 
mHx = (c0*dt)./UR; 

% Initialise fields
Ey = zeros(1, nz_grid);
Hx = zeros(1, nz_grid);


%% Main Loop %%
for T = 1 : STEPS
  % Update H from E
  for nz = 1: nz_grid-1
      Hx(nz) = Hx(nz) + mHx(nz)*( Ey(nz+1) - Ey(nz))/dz;
  endfor
  Hx(nz_grid) = Hx(nz_grid) + mHx(nz_grid)*( 0 - Ey(nz_grid))/dz;
  %Update E from H
  Ey(1) = Ey(1) + mEy(1)*(Hx(1) - 0)/dz;
  for nz = 2 : nz_grid
    Ey(nz) = Ey(nz) + mEy(nz)*(Hx(nz) - Hx(nz-1))/dz;
  end
  
  % Include source
  Ey(nz_src) = Ey(nz_src) + e_src(T)
  
  % Show status (updates every 10 iterations)
  if ~mod(T,5)
    % show fields
    % d raw1d(ER, Ey, Hz, dz);
    hor_axis = dz:dz:nz_grid*dz;
    plot(za, Ey,'b', za, Hx,'r',linewidth=2);
    xlim([dz nz_grid*dz]);
    xlabel('z');
    title(['Field at step ' num2str(T) ' of ' num2str(STEPS)]);
    drawnow
  endif
  
endfor


