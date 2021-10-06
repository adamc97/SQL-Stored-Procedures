DROP PROCEDURE sp_two;

CREATE PROCEDURE sp_two ()

BEGIN

    WITH month_cte AS (
        SELECT t.category, 
	       m.id AS Month, 
	       SUM(t.price) AS Price
        FROM transactions t
        LEFT JOIN month m
        ON MID(t.purchase_date, 6, 2) = m.code
        GROUP BY m.id, t.category
    )
    SELECT t.category,
    	   m1.Price AS 'January',
    	   m2.Price AS 'February',
    	   m3.Price AS 'March',
    	   m4.Price AS 'April',
    	   m5.Price AS 'May',
    	   m6.Price AS 'June',
    	   m7.Price AS 'July',
    	   m8.Price AS 'August',
    	   m9.Price AS 'September',
    	   m10.Price AS 'October',
    	   m11.Price AS 'November',
           m12.Price AS 'December'
    FROM transactions t
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 1
    ) m1
    ON m1.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 2
    ) m2
    ON m2.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 3
    ) m3
    ON m3.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 4
    ) m4
    ON m4.category = t.category
     LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 5
    ) m5
    ON m5.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 6
    ) m6
    ON m6.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 7
    ) m7
    ON m7.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 8
    ) m8
    ON m8.category = t.category
     LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 9
    ) m9
    ON m9.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 10
    ) m10
    ON m10.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 11
    ) m11
    ON m11.category = t.category
    LEFT JOIN (
        SELECT * FROM month_cte WHERE Month = 12
    ) m12
    ON m12.category = t.category
    GROUP BY t.category;

END;