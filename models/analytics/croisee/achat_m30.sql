WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_client AS (
    SELECT * FROM {{ ref('dim_client') }}
),
dim_produit AS (
    SELECT * FROM {{ ref('dim_produit') }}
)
SELECT
    ANY_VALUE(p.nom) AS produit,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_client AS c
ON v.id_client = c.id
INNER JOIN dim_produit AS p
ON v.id_produit = p.id
WHERE c.age < 30
GROUP BY p.id
ORDER BY nb_vendus DESC

