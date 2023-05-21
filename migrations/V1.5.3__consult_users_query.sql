


USE [Esencial V]


SET STATISTICS IO ON
SET STATISTICS TIME ON


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
    LEFT JOIN users usrs ON usrs.producer_id = prd.producer_id
    RIGHT JOIN containers_inventories cont_inv ON cont_inv.producer_id = prd.producer_id
    JOIN corporations crp ON prd.corporation_id = crp.corporation_id
WHERE 
    usrs.position NOT IN ('CEO', 'Director of HR')  
    AND usrs.created_at BETWEEN '2023-02-01' AND '2023-12-01'

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
EXCEPT
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
    LEFT JOIN users usrs ON usrs.producer_id = prd.producer_id
    RIGHT JOIN containers_inventories cont_inv ON cont_inv.producer_id = prd.producer_id
    JOIN corporations crp ON prd.corporation_id = crp.corporation_id
WHERE 
 usrs.created_at BETWEEN '2023-05-01' AND '2023-05-15'
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
ORDER BY 
	prd.producer_id;


