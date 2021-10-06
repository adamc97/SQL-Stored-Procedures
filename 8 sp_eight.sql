DROP PROCEDURE sp_eight;

CREATE PROCEDURE sp_eight ()

BEGIN


SELECT 'Latest Transaction:', t.id AS 'ID', t.category AS 'Category', c.name AS 'Country', t.price AS 'Price', t.purchase_date AS 'Date', t.comments AS 'Comments'
FROM transactions t
LEFT JOIN month m
ON SUBSTRING(t.purchase_date, 6, 2) = m.code
LEFT JOIN country c
ON t.country = c.id
WHERE t.id = (
	SELECT MAX(t.id) 
	FROM transactions t
);

END;