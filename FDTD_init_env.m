% FDTD_init_env.m
% Basic FDTD Engine

% Initialise matlab/octave
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

% FDTD parameters
dz = 0.006; % grid resolution in the z direction
Nz = 200; % 200 points in the grid
dt = 1e-11; % time step (0.1ps)
STEPS = 1000; % 1000 time steps

%% Construct device on grid %%

% Initialise material to free space
ER = ones(1, Nz);% Relative permeability 
UR = ones(1, Nz);% Relative permitivity

%% Initialise FDTD parameters %%

% Compute update coefficients
mEy = (c0*dt)./ER; 
mHx = (c0*dt)./UR; 

% Initialise fields
Ey = zeros(1, Nz);
Hx = zeros(1, Nz);




%% Main Loop %%
for T = 1 : STEPS
  % Update H from E
  for nz = 1: Nz-1
      Hx(nz) = Hx(nz) + mHx(nz)*( Ey(nz+1) - Ey(nz))/dz;
  endfor
  Hx(Nz) = Hx(Nz) + mHx(Nz)*( 0 - Ey(Nz))/dz;
  %Update E from H
  Ey(1) = Ey(1) + mEy(1)*(Hx(1) - 0)/dz;
  for nz = 2 : Nz
    Ey(nz) = Ey(nz) + mEy(nz)*(Hx(nz) - Hx(nz-1))/dz;
  endfor
  
  % Show status (updates every 10 iterations)
  if ~mod(T,10)
    % show fields
    % d raw1d(ER, Ey, Hz, dz);
    hor_axis = dz:dz:Nz*dz;
    plot(hor_axis, Ey, hor_axis, Hx);
    xlim([dz Nz*dz]);
    xlabel('z');
    title(['Field at step ' num2str(T) ' of ' num2str(STEPS)]);
    drawnow
  endif
  
endfor


