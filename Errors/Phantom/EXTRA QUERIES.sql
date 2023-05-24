SELECT * FROM producers prd
JOIN addresses addr ON prd.address_id=addr.address_id
WHERE zip_code = 6662

DELETE FROM producers WHERE producer_id=71027