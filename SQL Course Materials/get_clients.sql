@DELIMITER $$
CREATE PROCEDURE get_invoice_with_balance1()
BEGIN
SELECT 
    * ,
    invoice_total - payment_total AS balance
FROM sql_invoicing.invoices
GROUP BY invoice_id 
HAVING invoice_total - payment_total > 0
ORDER BY balance DESC
END 
@DELIMITER ;

USE sql_invoicing;
DROP PROCEDURE IF EXISTS get_clients;
-- 注意加上【IF EXISTS】，以免因为此过程不存在而报错
DELIMITER $$
    CREATE PROCEDURE get_clients()
        BEGIN
            SELECT * FROM clients;
        END$$
DELIMITER ;
CALL get_clients();