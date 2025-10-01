WITH ventes AS (
    SELECT * FROM {{ ref('stg_ventes') }}
),
final AS (
    SELECT
        row_number() over () AS id,
        produit_nom AS nom,
        produit_categorie AS categorie,
        produit_marque AS marque
    FROM ventes
    GROUP BY nom, categorie, marque
    ORDER BY categorie, marque, nom
)

SELECT * FROM final