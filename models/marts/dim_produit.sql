WITH ventes AS (
    SELECT * FROM {{ ref('stagged_ventes') }}
),
final AS (
    SELECT
        row_number() over () AS id,
        produit_nom AS nom,
        produit_categorie AS categorie,
        produit_marque AS marque,
        prix_catalogue
    FROM ventes
    GROUP BY nom, categorie, marque, prix_catalogue
    ORDER BY categorie, marque, nom, prix_catalogue
)

SELECT * FROM final