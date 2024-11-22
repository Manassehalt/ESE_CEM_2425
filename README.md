# ESE_CME_2425

I.	Exécution du script tp00.m
Objectif de cette étape
L’objectif de cette étape est d’exécuter un script MATLAB/Octave permettant de résoudre numériquement l’équation de Laplace en 2D à l’aide de la méthode des différences finies. Ce script initialise un domaine de calcul de dimensions 40×40 avec des potentiels sources et des conditions aux limites, et produit une visualisation graphique du potentiel V dans tout le domaine.
Description et analyse du script
1. Définition des paramètres et du domaine de calcul
•	Les dimensions du maillage unitaire  (dx=1, dy=1) ainsi que le nombre de cellules (Nx=40, Ny=40) sont définis pour le domaine.
•	Les conditions aux limites sont fixées à V=0 sur les bords du domaine, simulant un potentiel nul à l’infini.
•	Deux conducteurs sont définis comme sources de potentiel avec :
o	V1=100 V pour le premier conducteur.
o	V2=−100V pour le second conducteur.
2. Initialisation et conditions aux limites
•	Une matrice V est initialisée à zéro pour représenter le potentiel dans tout le domaine.
•	Les conditions aux limites sont appliquées sur les bords du domaine, garantissant V=0 sur les extrémités (x=1, x=40, y=1, y=40).
3. Définition des conducteurs
Les conducteurs sont positionnés dans le domaine :
•	Le premier conducteur est représenté par une barre horizontale située entre les cellules (25:28,8:34) avec un potentiel V=100.
•	Le second conducteur est une barre verticale entre les cellules (5:22,20:21)(5:22, 20:21)(5:22,20:21) avec un potentiel V=−100V.









5. Visualisation des résultats
Deux représentations graphiques sont produites :
1.	Visualisation des conditions initiales
Ce graphe montre les conducteurs +100 V (en rouge) et −100V (en bleu) dans un domaine initialisé à V=0 :
 
