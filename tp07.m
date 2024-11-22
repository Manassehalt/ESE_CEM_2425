% Resolution equation de Laplace
clear
close all
clc

% Liste des tailles de domaine à tester
taille_domaines = [10, 20, 40, 80, 100]; % Vous pouvez ajuster les valeurs ici

% Potentiels / sources
v0 = 0; % condition aux limites (en V)
v1 = 100; % conducteur 1
v2 = -100; % conducteur 2

% Proportions des indices des cellules sources par rapport à la taille Nx et Ny initiale (40x40)
dx = 1;
dy = 1;
epsilon0 = 8.85e-12; 
Nx_orig = 40;
Ny_orig = 40;
Nx_v1_start_ratio = 8 / Nx_orig;
Nx_v1_end_ratio = 34 / Nx_orig;
Ny_v1_start_ratio = 25 / Ny_orig;
Ny_v1_end_ratio = 28 / Ny_orig;
Nx_v2_start_ratio = 20 / Nx_orig;
Nx_v2_end_ratio = 21 / Nx_orig;
Ny_v2_start_ratio = 5 / Ny_orig;
Ny_v2_end_ratio = 22 / Ny_orig;

for k = 1:length(taille_domaines)
    Nx = taille_domaines(k);
    Ny = taille_domaines(k);
    
    % Initialisation de la matrice de calcul
    V = zeros(Nx, Ny); % Mettre toute la matrice à zéro
    
    % Conditions aux limites
    V(1, 1:Ny) = 0; % On fixe la première ligne à 0
    V(Nx, 1:Ny) = 0; % On fixe la dernière ligne à 0
    V(1:Nx, 1) = 0; % On fixe la première colonne à 0
    V(1:Nx, Ny) = 0; % On fixe la dernière colonne à 0
    
    % Calcul des indices des cellules sources en fonction de la taille du domaine
    Nx_v1_start = round(Nx_v1_start_ratio * Nx);
    Nx_v1_end = round(Nx_v1_end_ratio * Nx);
    Ny_v1_start = round(Ny_v1_start_ratio * Ny);
    Ny_v1_end = round(Ny_v1_end_ratio * Ny);
    Nx_v2_start = round(Nx_v2_start_ratio * Nx);
    Nx_v2_end = round(Nx_v2_end_ratio * Nx);
    Ny_v2_start = round(Ny_v2_start_ratio * Ny);
    Ny_v2_end = round(Ny_v2_end_ratio * Ny);
    
    % Ajout des cellules sources
    V(Ny_v1_start:Ny_v1_end, Nx_v1_start:Nx_v1_end) = 100; % Potentiel de 100V
    V(Ny_v2_start:Ny_v2_end, Nx_v2_start:Nx_v2_end) = -100; % Potentiel de -100V
    
    % Boucle de calcul pour n itérations
    seuil = 0.01;
    max_iterations = 1000; 
    iter = 0;
    diff = Inf;
    
    while (diff >= seuil) && (iter < max_iterations)
        V_old = V; % Sauvegarde de l'état précédent
        iter = iter + 1;
        
        % Mise à jour des valeurs de V (en excluant les bords)
        i = 2:Nx-1
        j = 2:Ny-1
        V(i, j) = 0.25 * (V(i+1, j) + V(i-1, j) + V(i, j+1) + V(i, j-1));

        % Réappliquer les potentiels des sources
        V(Ny_v1_start:Ny_v1_end, Nx_v1_start:Nx_v1_end) = 100;
        V(Ny_v2_start:Ny_v2_end, Nx_v2_start:Nx_v2_end) = -100;

        % Réappliquer les potentiels des bords
        V(1,1:Ny) = v0; %On fixe la premiére ligne à v0
        V(Nx,1:Ny) = v0; %On fixe la derniére ligne à v0
        V(1:Nx,1) = v0; %On fixe la premiére ligne à v0
        V(1:Nx,Ny) = v0; %On fixe la derniére ligne à v0

        % Calcul de la variation maximale entre les deux itérations
        diff = max(abs(V - V_old), [], 'all');
    end
    
    % Calcul des composantes du gradient
    [Ex, Ey] = gradient(-V, dx, dy);

    % Calcul de la charge Qi via l'intégrale discrète sur un contour autour du conducteur 1
    
    Bord_Gauche = sum(Ey(Ny_v1_start:Ny_v1_end, Nx_v1_start) * dy); % Bord gauche
    Bord_Droit = -sum(Ey(Ny_v1_end:Ny_v1_end, Nx_v1_end) * dy); % Bord droit
    Bord_Haut = sum(Ex(Ny_v1_start, Nx_v1_start:Nx_v1_end) * dx); % Bord haut
    Bord_Bas =-sum(Ex(Ny_v1_end, Nx_v1_start:Nx_v1_end) * dx); % Bord bas
    Qi = (Bord_Gauche + Bord_Droit + Bord_Haut + Bord_Bas) * epsilon0; % Conversion en Coulombs

    % Calcul de la capacité Cij
    Cij = Qi / (v1 - v2); % en Farads

    % Affichage des résultats pour cette taille de domaine
    figure;
    colormap("jet");
    pcolor(V);
    contour(V); 
    hold on;
    quiver(1:Nx,1:Ny,Ex,Ey);
    hold off;
    title(['Potentiel après ' num2str(iter) ' itérations, Taille du domaine: ' num2str(Nx) 'x' num2str(Ny) ', Capacité C_{ij} = ' num2str(Cij, '%.2e') ' F']);
end


