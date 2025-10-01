WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_client AS (
    SELECT * FROM {{ ref('dim_client') }}
)
SELECT
    CONCAT(
        CAST((c.age / 10)*10 AS CHAR(2)),
        '-', 
        CAST((c.age / 10)*10+9 AS CHAR(2))
    ) AS tranche_age,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) AS ca
FROM fact_ventes AS v
INNER JOIN dim_client AS c
ON v.id_client = c.id
GROUP BY tranche_age
ORDER BY ca DESC

