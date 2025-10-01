WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
)
SELECT
    m.type AS type,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_magasin AS m
ON v.id_magasin = m.id
GROUP BY m.type
ORDER BY ca DESC

