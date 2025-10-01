WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
)
SELECT
    ANY_VALUE(m.nom) AS nom,
    COUNT(id_transaction) AS nb_transac
FROM fact_ventes AS v
INNER JOIN dim_magasin AS m
ON v.id_magasin = m.id
WHERE m.type = 'physique'
GROUP BY m.id
ORDER BY nb_transac DESC

