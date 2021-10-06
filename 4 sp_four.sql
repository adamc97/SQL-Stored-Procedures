DROP PROCEDURE sp_four;

CREATE PROCEDURE sp_four (IN month VARCHAR(15))

BEGIN

SET @starting_balance := (
	SELECT sb.balance
	FROM start_balance sb
  	WHERE sb.month_id = (
		SELECT m.id
      	FROM month m
      	WHERE m.name = month
  	)
);

SET @savings_amount := (
    SELECT st.amount
    FROM savings_target st
    WHERE st.month_id = (
        SELECT m.id
        FROM month m
        WHERE m.name = month
    )
);
      
SELECT (@starting_balance - MAX(sub.cumulative_price))/(MAX(DAY(LAST_DAY(sub.date)))-MAX(SUBSTRING(sub.date, 9, 2))) AS 'Daily Remaining Budget',
       (@starting_balance - MAX(sub.cumulative_price) - @savings_amount)/(MAX(DAY(LAST_DAY(sub.date)))-MAX(SUBSTRING(sub.date, 9, 2))) AS 'Daily Remaining Budget (s)'
FROM (
	SELECT t.id, t.purchase_date AS date, t.price, SUM(t.price) OVER (ORDER BY t.purchase_date, t.id) AS cumulative_price
	FROM transactions t
	LEFT JOIN month m
	ON SUBSTRING(t.purchase_date, 6, 2) = m.code
	LEFT JOIN start_balance sb
	ON m.id = sb.month_id
	AND SUBSTRING(t.purchase_date, 1, 4) = sb.year
	WHERE m.name = month
	ORDER BY t.purchase_date, t.id
) sub
LEFT JOIN month m
ON SUBSTRING(sub.date, 6, 2) = m.code
WHERE m.name = month;

END;