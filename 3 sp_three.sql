DROP PROCEDURE sp_three;

CREATE PROCEDURE sp_three (IN month VARCHAR(15))

BEGIN

SELECT t.id AS 'ID', 
       t.purchase_date AS 'Date', 
       m.name AS 'Month', 
       SUBSTRING(t.purchase_date, 9, 2) AS 'Day', 
       DAYNAME(t.purchase_date) AS 'Name', 
       t.price AS 'Price', 
       sb.balance/DAY(LAST_DAY(t.purchase_date)) AS 'Daily Limit', 
       (sb.balance - st.amount)/DAY(LAST_DAY(t.purchase_date)) AS 'Daily Limit (s)', 
       SUM(t.price) OVER (ORDER BY t.purchase_date, t.id) AS 'Cumulative Price', 
       (sb.balance/DAY(LAST_DAY(t.purchase_date)))*(SUBSTRING(t.purchase_date, 9, 2)) AS 'Cumulative Daily Limit', 
       ((sb.balance - st.amount)/DAY(LAST_DAY(t.purchase_date)))*(SUBSTRING(t.purchase_date, 9, 2)) AS 'Cumulative Daily Limit (s)', 
       sub.price AS 'Format Price'
FROM transactions t
LEFT JOIN month m
ON SUBSTRING(t.purchase_date, 6, 2) = m.code
LEFT JOIN start_balance sb
ON m.id = sb.month_id
LEFT JOIN savings_target st
ON m.id = st.month_id
LEFT JOIN (
  SELECT t.purchase_date, SUM(t.price) as price
  FROM transactions t
  GROUP BY t.purchase_date
) sub
ON t.purchase_date = sub.purchase_date
WHERE m.name = month
ORDER BY t.purchase_date, t.id;

END;