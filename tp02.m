% Resolution equation de Laplace
%
clear
close all
clc

%% Dimensions / maillage
dx=1; % cm
dy=1; % cm
Nx = 40;
Ny = 40;

%% Potentiels / sources
v0 = 0; % condition aux limites (en V)
v1 = 100; % conducteur 1
v2 = -100; % conducteur 2

% Initialisation la matrice de calcul
V = zeros(Nx,Ny); % mettre toute la matrice a zero

%Conditions aux limites
%for j=1:Ny
%    V(i,j) = v0;
%end

V(1,1:Ny) = v0; %On fixe la premiére ligne à v0
V(Nx,1:Ny) = v0; %On fixe la derniére ligne à v0
V(1:Nx,1) = v0; %On fixe la premiére ligne à v0
V(1:Nx,Ny) = v0; %On fixe la derniére ligne à v0

%Ajout des cellues sources :
Nx_v1_start = 8;
Nx_v1_end = 34;
Ny_v1_start = 25;
Ny_v1_end = 28;
Nx_v2_start = 20;
Nx_v2_end = 21;
Ny_v2_start = 5;
Ny_v2_end = 22;

V(Ny_v1_start:Ny_v1_end,Nx_v1_start:Nx_v1_end) = v1;
V(Ny_v2_start:Ny_v2_end,Nx_v2_start:Nx_v2_end) = v2;

figure(11);
colormap("jet");
pcolor(V);


% Equation de calcul
%i=1;j=1;
for iter = 1:200
    i=2:Nx-1;
    j=2:Ny-1;
    V(i,j)=0.25*( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) );
    V(Ny_v1_start:Ny_v1_end,Nx_v1_start:Nx_v1_end) = v1;
    V(Ny_v2_start:Ny_v2_end,Nx_v2_start:Nx_v2_end) = v2;
end


% Figure
figure(12);
colormap("jet");
pcolor(V);


