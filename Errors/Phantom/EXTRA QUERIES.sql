-- consultas de control para verificación

SELECT * FROM producers prd
JOIN addresses addr ON prd.address_id=addr.address_id
WHERE zip_code = 6662

DELETE FROM producers WHERE name='Abejorro Gigante'