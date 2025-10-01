WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
)
SELECT
    m.type AS type,
    CAST(
        COUNT(id_transaction)*100.0 / (SELECT COUNT(*) FROM fact_ventes) 
        AS SMALLINT
    ) AS perc_ventes
FROM fact_ventes AS v
INNER JOIN dim_magasin AS m
ON v.id_magasin = m.id
GROUP BY m.type

