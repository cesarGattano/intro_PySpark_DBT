WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_client AS (
    SELECT * FROM {{ ref('dim_client') }}
)
SELECT
    ville,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_client AS c
ON v.id_client = c.id
GROUP BY ville
ORDER BY ca DESC

