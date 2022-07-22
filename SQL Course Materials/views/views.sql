USE sql_invoicing;

CREATE VIEW sales_by_client AS 
SELECT 
    client_id,
    name,
    sum(invoice_total) AS total_sales
FROM clients c
JOIN invoices 
    using (client_id)
GROUP BY client_id, name

USE sql_invoicing;

CREATE VIEW payment_balance as
SELECT 
    client_id,
    name,
    sum(invoice_total) - sum(payment_total) as patment_balance
FROM clients c
JOIN invoices i
    USING(client_id)
GROUP BY client_id ,name
