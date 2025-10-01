WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_temps AS (
    SELECT * FROM {{ ref('dim_temps') }}
),
dim_produit AS (
    SELECT * FROM {{ ref('dim_produit') }}
)
SELECT
    month,
    case
        when month = 1 then 'janvier'
        when month = 2 then 'février'        
        when month = 3 then 'mars'        
        when month = 4 then 'avril'        
        when month = 5 then 'mai'        
        when month = 6 then 'juin'        
        when month = 7 then 'juillet'        
        when month = 8 then 'août'        
        when month = 9 then 'septembre'        
        when month = 10 then 'octobre'        
        when month = 11 then 'novembre'          
        when month = 11 then 'decembre'       
    end as nom_month,
    ANY_VALUE(p.nom) AS produit,
    COUNT(id_transaction) AS nb_transac,
    SUM(quantite) AS nb_vendus
FROM fact_ventes AS v
INNER JOIN dim_temps AS t
ON v.date = t.date
INNER JOIN dim_produit AS p
ON v.id_produit = p.id
GROUP BY p.id, month
ORDER BY produit, month

