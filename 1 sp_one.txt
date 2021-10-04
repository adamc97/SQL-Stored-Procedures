DROP PROCEDURE sp_one;

CREATE PROCEDURE sp_one (IN month VARCHAR(15))

BEGIN

	SET @month_no := (
		SELECT m.id
		FROM month m
		WHERE m.name = month
	);

	SET @starting_amount := (
		SELECT sb.balance
		FROM start_balance sb
		WHERE sb.month_id = @month_no
	);

	SELECT t.id AS 'ID', 
	       t.purchase_date AS 'Purchase Date', 
	       t.category AS 'Category', 
	       t.price AS 'Price', 
	       @starting_amount - (SUM(t.price) OVER (ORDER BY t.id)) AS 'Remaining Balance'
	FROM transactions t
	LEFT JOIN month m
	ON MID(t.purchase_date, 6, 2) = m.code
	WHERE m.id = @month_no
	ORDER BY t.id;

END;