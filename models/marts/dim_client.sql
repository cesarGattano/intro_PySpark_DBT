WITH ventes AS (
    SELECT * FROM {{ ref('stg_ventes') }}
),
final AS (
    SELECT
        row_number() over () AS id,
        client_nom AS nom,
        client_age AS age,
        client_ville AS ville
    FROM ventes
    GROUP BY client_nom, client_age, client_ville
    ORDER BY client_nom, client_age, client_ville
)

SELECT * FROM final