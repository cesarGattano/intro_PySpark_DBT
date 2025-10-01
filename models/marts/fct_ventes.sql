WITH ventes AS (
    SELECT * FROM {{ ref('stg_ventes') }}
),
dim_temps AS (
    SELECT date FROM {{ ref('dim_temps') }}
),
dim_client AS (
    SELECT * FROM {{ ref('dim_client') }}
),
dim_magasin AS (
    SELECT * FROM {{ ref('dim_magasin') }}
),
dim_produit AS (
    SELECT * FROM {{ ref('dim_produit') }}
),
final AS (
    SELECT
        v.id AS id,
        id_transaction,
        c.id AS id_client,
        p.id AS id_produit,
        m.id AS id_magasin,
        v.date AS date,
        quantite,
        prix_catalogue AS prix_unitaire,
        montant_total
    FROM ventes AS v
    INNER JOIN dim_temps AS t
    ON v.date = t.date
    INNER JOIN dim_client AS c
    ON v.client_nom = c.nom AND v.client_age = c.age AND v.client_ville = c.ville
    INNER JOIN dim_produit AS p
    ON v.produit_nom = p.nom AND v.produit_categorie = p.categorie AND v.produit_marque = p.marque
    INNER JOIN dim_magasin AS m
    ON v.magasin_nom = m.nom AND v.magasin_type = m.type AND v.magasin_region = m.region
)

SELECT * FROM final