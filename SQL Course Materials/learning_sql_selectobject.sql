select 
	first_name, 
	last_name, 
	points, 
	(points + 10) * 100 as 'discount factor 嘿 嘿'
from customers 
