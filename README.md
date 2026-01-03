# 📊 Projet SQL : Automatisation des Rapports de Ventes (Chinook)

## 📝 Description du projet
Ce projet consiste à analyser les données de la base **Chinook** (une base de données simulant un magasin de musique numérique) pour répondre à des problématiques métier concrètes. L'objectif principal est d'extraire, filtrer et agréger des données afin de produire des rapports de performance et d'automatiser le suivi des indicateurs clés (KPI).

## 🛠️ Outils et Technologies
* **Base de données :** SQLite (Chinook Database)
* **Interface :** SQLiteStudio 3.4.0
* **Langage :** SQL (Jointures complexes, Agrégations, Fonctions de date, Vues)

## 🔍 Analyses réalisées
Le fichier `chinook-queries.sql` contient des requêtes répondant à plusieurs besoins analytiques :
1.  **Gestion Clientèle :** Identification des segments géographiques (clients hors USA, focus sur le Brésil).
2.  **Performance Commerciale :** Analyse des factures par agent de vente et identification des meilleurs vendeurs par année (2009, 2010) et globalement.
3.  **Analyse Produit :** Classement des morceaux les plus vendus, des types de médias préférés et des artistes les plus populaires.
4.  **Logistique :** Détails des lignes de facture, comptage des articles par playlist et par pays.

## ⚙️ Automatisation via les Vues (Views)
Pour éviter la répétition de requêtes complexes, j'ai implémenté une **Vue SQL** (`View_SalesPerformance`) qui permet de consulter en temps réel le chiffre d'affaires généré par chaque agent de vente, classé par année. Cela permet une mise à jour automatique du rapport dès que de nouvelles factures sont ajoutées à la base.

## 📈 Conclusions de l'analyse
* **Domination du Rock :** Les artistes comme Iron Maiden et U2 représentent une part majeure du volume de ventes.
* **Marchés Clés :** Les États-Unis restent le marché principal, suivis par le Canada et le Brésil.
* **Top Talent :** Jane Peacock est identifiée comme l'agent de vente le plus performant sur la durée totale des données.

## 🚀 Comment utiliser ce projet ?
1.  Téléchargez le fichier `Chinook_Sqlite.sqlite`.
2.  Ouvrez-le dans **SQLiteStudio** ou **DB Browser for SQLite**.
3.  Exécutez les scripts présents dans `chinook-queries.sql` pour visualiser les résultats.
