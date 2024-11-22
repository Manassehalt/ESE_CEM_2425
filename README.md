<p align="left"> <img src="Graphique_Logo/logo ENSEA.png" width="15%" height="auto" /> </p>
# ESE_CME_2425
JAQUOT NOLAN GUIFFAULT GABRIEL
## I.	Exécution du script tp00.m
Objectif de cette étape
L’objectif de cette étape est d’exécuter un script MATLAB/Octave permettant de résoudre numériquement l’équation de Laplace en 2D à l’aide de la méthode des différences finies. Ce script initialise un domaine de calcul de dimensions 40×40 avec des potentiels sources et des conditions aux limites, et produit une visualisation graphique du potentiel V dans tout le domaine.
### Description et analyse du script
_1. Définition des paramètres et du domaine de calcul_

•	Les dimensions du maillage unitaire  (dx=1, dy=1) ainsi que le nombre de cellules (Nx=40, Ny=40) sont définis pour le domaine.

•	Les conditions aux limites sont fixées à V=0 sur les bords du domaine, simulant un potentiel nul à l’infini.

•	Deux conducteurs sont définis comme sources de potentiel avec :

 o	V1=100 V pour le premier conducteur.
 
 o	V2=−100V pour le second conducteur.
 
_2. Initialisation et conditions aux limites_

•	Une matrice V est initialisée à zéro pour représenter le potentiel dans tout le domaine.

•	Les conditions aux limites sont appliquées sur les bords du domaine, garantissant V=0 sur les extrémités (x=1, x=40, y=1, y=40).

_3. Définition des conducteurs_
   
Les conducteurs sont positionnés dans le domaine :
•	Le premier conducteur est représenté par une barre horizontale située entre les cellules (25:28,8:34) avec un potentiel V=100.

•	Le second conducteur est une barre verticale entre les cellules (5:22,20:21)(5:22, 20:21)(5:22,20:21) avec un potentiel V=−100V.









5. Visualisation des résultats
Deux représentations graphiques sont produites :
 1.	Visualisation des conditions initiales
 Ce graphe montre les conducteurs +100 V (en rouge) et −100V (en bleu) dans un domaine initialisé à V=0 :
 















## II.	Résolution itérative de l’équation de Laplace (200 itérations)
Objectif de cette étape
L’objectif est de modifier le script MATLAB/Octave pour résoudre numériquement l’équation de Laplace en 2D à l’aide de la méthode des différences finies (DF) sur un domaine de 40×40. Cette résolution itérative (200 itérations) permet d’obtenir une distribution stable du potentiel V dans tout le domaine.
Description de la méthode et du script
Dans cette étape, une boucle itérative est ajoutée pour appliquer l’équation discrétisée de Laplace :
V(i,j)=0.25*( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) )
Le potentiel est calculé pour chaque point du domaine interne (excluant les bords) jusqu’à convergence approximative après 200 itérations.
Modifications apportées au script
1.	Ajout d’une boucle itérative pour mettre à jour les valeurs de V(i,j) selon la méthode DF.
2.	Réimposition des potentiels fixes +100V et −100V sur les conducteurs à chaque itération pour garantir leur stabilité.

Résultat
Ce graphe obtenu montre une distribution stable du potentiel après 200 itérations :
•	Une transition progressive entre les potentiels +100V (en rouge) et −100V (en bleu).
•	Un gradient de potentiel visible dans tout le domaine, illustrant les interactions entre les deux conducteurs.
 

## III.	Convergence et seuil de convergence
Objectif de cette étape
L’objectif est de résoudre l’équation de Laplace en 2D en ajoutant un critère de convergence basé sur la variation maximale du potentiel V entre deux itérations successives. Cette méthode permet d’arrêter la simulation lorsque la solution devient suffisamment stable, évitant ainsi un nombre arbitraire d’itérations.
Méthode et description du script
1. Paramètres de convergence
•	Seuil de convergence (seuil) : Définit la précision souhaitée pour la variation maximale du potentiel entre deux itérations successives. Dans ce script, le seuil est défini à 0.010.010.01, mais d'autres valeurs (0.001,0.0001,…)peuvent être testées.
•	Nombre maximum d’itérations (max_iterations) : Définit une limite pour éviter des boucles infinies si la convergence n'est pas atteinte.
2. Boucle de calcul
•	À chaque itération, une copie de l’état précédent du potentiel (V) est conservée dans Vold.
•	La méthode des différences finies est appliquée pour mettre à jour 
V : V(i, j) = 0.25 * (V(i+1, j) + V(i-1, j) + V(i, j+1) + V(i, j-1));
•	Les potentiels des conducteurs (v1 et v2) sont réimposés après chaque mise à jour pour garantir leur stabilité.
•	Le test de convergence compare V et Vold en calculant la variation maximale : diff=max(∥V−Vold∥)
•	La boucle s’arrête si la variation maximale devient inférieure au seuil.
3. Visualisation des résultats
•	Le potentiel V final est affiché avec pcolor après la convergence ou après avoir atteint le nombre maximum d’itérations.









Résultats 
•	Le nombre d’itérations nécessaire pour atteindre la convergence dépend du seuil choisi (0.01,0.001, etc.). Par exemple :
o	Avec seuil=0.01, la convergence est atteinte en environ 284 itérations :
 
o	Avec seuil=0.001, la convergence est atteinte en environ 491 itérations :.
o	 
•	La méthode permet d’éviter des calculs inutiles tout en obtenant une solution stable.










## IV.	Étude de l’influence de la taille du domaine de calcul
Objectif de cette étape
Cette étape explore l'effet de la taille du domaine de calcul sur la distribution du potentiel V et la convergence des résultats. En augmentant ou réduisant les dimensions du domaine (Nx×Ny), on évalue l'impact sur la répartition des potentiels et la précision de la solution.
Méthode et description du script
1. Dimensions variables
•	Le domaine de calcul est testé pour plusieurs tailles : 10×10, 20×20, 40×40, 80×80, et 100×100.
•	Les proportions des cellules sources (V1=+100V et V2=−100V) sont ajustées proportionnellement à la taille du domaine.
2. Boucle de calcul pour chaque taille
Initialisation :
•	Les conditions aux limites (V=0) sont appliquées sur tous les bords du domaine.
•	Une matrice V est initialisée à zéro pour représenter le potentiel dans tout le domaine.
Itérations pour chaque taille :
•	À chaque itération, le potentiel V est mis à jour selon la méthode des différences finies : 
V(i, j) = 0.25 * (V(i+1, j) + V(i-1, j) + V(i, j+1) + V(i, j-1))
•	Les potentiels des conducteurs (v1 et v2) sont réimposés pour garantir leur stabilité.
Critère de convergence :
•	Une copie de V (Vold) est conservée à chaque itération.
•	La variation maximale entre deux itérations est calculée : diff=max(∣V−Vold∣)
•	La boucle s’arrête si diff<seuil (seuil=0.01) ou si le nombre maximum d’itérations (max_iterations=1000) est atteint.
3. Visualisation des résultats
•	Une figure est générée pour chaque taille de domaine, montrant la distribution finale du potentiel après convergence.






Résultats : 

