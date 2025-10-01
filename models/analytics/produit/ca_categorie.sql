WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_produit AS (
    SELECT * FROM {{ ref('dim_produit') }}
)
SELECT
    p.categorie,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_produit AS p
ON v.id_produit = p.id
GROUP BY p.categorie
ORDER BY ca DESC

