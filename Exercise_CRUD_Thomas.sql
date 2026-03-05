-- 1. Afficher tous les métiers
SELECT * FROM metiers;

-- 2. Afficher uniquement le nom et la description des métiers
SELECT nom, description FROM metiers;

-- 3. Afficher tous les travailleurs âgés de plus de 30 ans
SELECT * FROM travailleurs WHERE age > 30;

-- 4. Afficher les métiers dangereux
SELECT * FROM metiers WHERE dangereux = TRUE;

-- 5. Afficher les missions durant plus de 5 heures
SELECT * FROM missions WHERE duree_heures > 5;

-- 6. Afficher les travailleurs ayant un salaire journalier supérieur à 4
SELECT * FROM travailleurs WHERE salaire_journalier > 4;

-- 7. Afficher les travailleurs âgés entre 25 et 40 ans
SELECT * FROM travailleurs WHERE age BETWEEN 25 AND 40;

-- 8. Afficher les métiers contenant les lettres 'eur'
SELECT * FROM metiers WHERE nom LIKE '%eur%';

-- 9. Afficher les travailleurs vivant à Londres, Paris, Rome ou Lausanne
SELECT t.* FROM travailleurs t
JOIN lieux l ON t.lieu_id = l.id
WHERE l.ville IN ('Londres', 'Paris', 'Rome', 'Lausanne');

-- 10. Afficher le nom du travailleur et son métier
SELECT t.nom, m.nom AS metier FROM travailleurs t
JOIN metiers m ON t.metier_id = m.id;

-- 11. Afficher le travailleur et la ville où il exerce
SELECT t.nom, l.ville FROM travailleurs t
JOIN lieux l ON t.lieu_id = l.id;

-- 12. Afficher le travailleur, le métier et la période historique correspondante
SELECT t.nom, m.nom AS metier, p.nom AS periode FROM travailleurs t
JOIN metiers m ON t.metier_id = m.id
JOIN periodes_historiques p ON m.periode_id = p.id;

-- 13. Afficher toutes les missions avec le nom du travailleur, la description et la durée
SELECT t.nom, mi.description, mi.duree_heures FROM missions mi
JOIN travailleurs t ON mi.travailleur_id = t.id;

-- 14. Ajouter un nouveau métier : Testeur de poison
INSERT INTO metiers (nom, description, dangereux, periode_id)
VALUES ('Testeur de poison', 'Goûte les plats avant les nobles', TRUE, 2);

-- 15. Ajouter un nouveau travailleur exerçant ce métier
INSERT INTO travailleurs (nom, age, metier_id, lieu_id, salaire_journalier)
VALUES ('Édouard', 27, 7, 2, 3.00);

-- 16. Augmenter de 1 unité le salaire journalier de tous les métiers dangereux
UPDATE travailleurs
SET salaire_journalier = salaire_journalier + 1
WHERE metier_id IN (SELECT id FROM metiers WHERE dangereux = TRUE);

-- 17. Modifier l'âge d'un travailleur de votre choix
UPDATE travailleurs SET age = 35 WHERE nom = 'Jeanne';

-- 18. Réduire de 1 heure toutes les missions de plus de 6 heures
UPDATE missions SET duree_heures = duree_heures - 1 WHERE duree_heures > 6;

-- 19. Supprimer les missions datant d'avant l'an 1200
DELETE FROM missions WHERE date_mission < '1200-01-01';

-- 20. Supprimer les travailleurs ayant un salaire inférieur à 2.5
DELETE FROM travailleurs WHERE salaire_journalier < 2.5;

-- 21. Supprimer les travailleurs exerçant un métier dangereux ET gagnant plus de 4
DELETE FROM travailleurs
WHERE metier_id IN (SELECT id FROM metiers WHERE dangereux = TRUE)
AND salaire_journalier > 4;

-- 22. Afficher le nombre total de travailleurs par métier
SELECT m.nom AS metier, COUNT(t.id) AS nombre_travailleurs FROM metiers m
LEFT JOIN travailleurs t ON t.metier_id = m.id
GROUP BY m.nom;

-- 23. Afficher la durée totale de travail par travailleur
SELECT t.nom, SUM(mi.duree_heures) AS duree_totale FROM travailleurs t
LEFT JOIN missions mi ON mi.travailleur_id = t.id
GROUP BY t.nom;

-- 24. Doubler le revenu du travailleur ayant effectué le plus de missions
UPDATE travailleurs
SET salaire_journalier = salaire_journalier * 2
WHERE id = (
    SELECT travailleur_id FROM missions
    GROUP BY travailleur_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
