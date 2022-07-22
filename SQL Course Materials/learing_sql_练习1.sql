USE sql_store ;
SELECT 
	name , 
	unit_price as 'unit price' ,
	unit_price * 1.1 as 'new price'
FROM products

