WITH ventes AS (
    SELECT date FROM {{ ref('stg_ventes') }}
),
final AS (
    SELECT
        date,
        EXTRACT(YEAR FROM date) AS year,
        EXTRACT(MONTH FROM date) AS month,
        EXTRACT(ISOYEAR FROM date) AS isoyear,
        EXTRACT(WEEK FROM date) AS week,
        EXTRACT(DAY FROM date) AS day,
        EXTRACT(DOW FROM date) AS dow,
        EXTRACT(DOY FROM date) AS doy
    FROM ventes
    GROUP BY date
    ORDER BY date
)

SELECT * FROM final