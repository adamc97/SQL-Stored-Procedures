DROP PROCEDURE sp_seven;

CREATE PROCEDURE sp_seven (IN month VARCHAR(15))

BEGIN

SELECT MIN(sub.balance) AS 'Remaining Balance' 
FROM (
	SELECT sb.balance - st.amount - (SUM(t.price) OVER (ORDER BY t.id)) AS balance
	FROM transactions t
	LEFT JOIN month m
	ON SUBSTRING(t.purchase_date, 6, 2) = m.code
	LEFT JOIN start_balance sb
	ON m.id = sb.month_id
	LEFT JOIN savings_target st
	ON m.id = st.month_id
	WHERE m.name = month
) sub;

END;
