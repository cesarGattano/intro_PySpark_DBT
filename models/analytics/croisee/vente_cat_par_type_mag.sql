WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
),
dim_produit AS (
    SELECT * FROM {{ ref('dim_produit') }}
)
SELECT
    m.type AS type_magasin,
    p.categorie AS categorie_produit,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_magasin AS m
ON v.id_magasin = m.id
INNER JOIN dim_produit AS p
ON v.id_produit = p.id
GROUP BY m.type, p.categorie
ORDER BY m.type, nb_vendus DESC

