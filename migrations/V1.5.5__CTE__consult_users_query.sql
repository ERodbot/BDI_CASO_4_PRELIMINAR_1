USE [Esencial Verde];

SET STATISTICS IO ON;
SET STATISTICS TIME ON;



WITH cte AS (
    SELECT 
        prd2.producer_id,
        cont_inv2.in_use,
        cont_inv2.on_maintenance,
        cont_inv2.available,
        cont_inv2.discarded,
        cont_inv2.lost_quantity
    FROM 
        producers prd2
        LEFT JOIN users usrs2 ON usrs2.producer_id = prd2.producer_id
        RIGHT JOIN containers_inventories cont_inv2 ON cont_inv2.producer_id = prd2.producer_id
    WHERE 
        usrs2.created_at BETWEEN '2023-05-01' AND '2023-05-15'
)
SELECT 
    usrs.name AS employerName,
    usrs.last_name AS employerSurname,
    usrs.username,
    usrs.position,
    prd.name AS producer,
    prd.producer_id,
    crp.name AS corporation,
    cont_inv.in_use,
    cont_inv.on_maintenance,
    cont_inv.available, 
    cont_inv.discarded, 
    cont_inv.lost_quantity,
    COUNT(usrs.user_id) AS totalEmployees
FROM 
    producers prd
    INNER JOIN users usrs ON usrs.producer_id = prd.producer_id
    INNER JOIN containers_inventories cont_inv ON cont_inv.producer_id = prd.producer_id
    INNER JOIN corporations crp ON prd.corporation_id = crp.corporation_id
WHERE 
    usrs.position NOT IN ('CEO', 'Director of HR')  
    AND usrs.created_at BETWEEN '2023-02-01' AND '2023-12-01'
    AND NOT EXISTS (
        SELECT 1
        FROM cte
        WHERE 
            prd.producer_id = cte.producer_id
            AND cont_inv.in_use = cte.in_use
            AND cont_inv.on_maintenance = cte.on_maintenance
            AND cont_inv.available = cte.available
            AND cont_inv.discarded = cte.discarded
            AND cont_inv.lost_quantity = cte.lost_quantity
    )
GROUP BY 
    crp.name, 
    crp.corporation_id,
    usrs.name, 
    usrs.last_name, 
    usrs.username, 
    usrs.position, 
    prd.name,
    prd.producer_id,
    cont_inv.in_use, 
    cont_inv.on_maintenance, 
    cont_inv.available, 
    cont_inv.discarded, 
    cont_inv.lost_quantity
ORDER BY prd.producer_id
