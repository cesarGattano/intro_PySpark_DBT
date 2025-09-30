with stagged_ventes as (
    SELECT
        id,
        id_transaction,
        client_nom,
        client_age,
        client_ville,
        produit_nom,
        produit_categorie,
        produit_marque,
        prix_catalogue,
        magasin_nom,
        magasin_type,
        magasin_region,
        date,
        quantite,
        montant_total
    FROM ventes
)

SELECT * FROM stagged_ventes