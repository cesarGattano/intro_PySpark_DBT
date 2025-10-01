WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
)
SELECT
    m.type AS type,
    CAST(
        SUM(montant_total)*100.0 / (SELECT SUM(montant_total) FROM fact_ventes) 
        AS SMALLINT
    ) AS perc_ventes
FROM fact_ventes AS v
INNER JOIN dim_magasin AS m
ON v.id_magasin = m.id
GROUP BY m.type

