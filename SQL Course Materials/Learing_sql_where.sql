SELECT *
FROM Customers
WHERE 
	#points < 3000 ,
    #比较运算符还有= < > => <= !=
    #state != 'VA'
    birth_date > '1990-01-01'
