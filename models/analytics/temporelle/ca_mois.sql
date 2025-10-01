WITH fact_ventes AS (
    SELECT * FROM {{ ref('fct_ventes') }}
),
dim_temps AS (
    SELECT * FROM {{ ref('dim_temps') }}
)
SELECT
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
        when month = 12 then 'decembre'       
    end as month,
    SUM(montant_total) AS ca,
    COUNT(id_transaction) AS nb_transactions,
    SUM(quantite) AS nb_vendus,
    SUM(montant_total) / COUNT(id_transaction) AS panier_moyen
FROM fact_ventes AS v
INNER JOIN dim_temps AS t
ON v.date = t.date
GROUP BY month
ORDER BY ca DESC

