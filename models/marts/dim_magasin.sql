WITH ventes AS (
    SELECT * FROM {{ ref('stagged_ventes') }}
),
final AS (
    SELECT
        row_number() over () AS id,
        magasin_nom AS nom,
        magasin_type AS type,
        magasin_region AS region
    FROM ventes
    GROUP BY nom, type, region
    ORDER BY type, region, nom
)

SELECT * FROM final