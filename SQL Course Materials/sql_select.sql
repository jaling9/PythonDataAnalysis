select *
from sql_store.customers
where NOT birth_date > '1990-01-01' 
 or (points > 1000 AND state = 'VA') --运算符的使用/

select *
from sql_store.order_items
where order_id = 6 
	and unit_price * quantity > 30 

select *
from sql_store.customers
where state in ('va','FL','ga')
select *
from sql_store.products
where quantity_in_stock in (49,38,72)

select *
from sql_store.customers
where points between 1000 and 3000 
select *
from sql_store.customers
where birth_date between '1990-01-01' and '2000-01-01'

select *
from sql_store.customers
-- where address like '%trail%' or 
-- 	address like '%avenue%' 
where phone like '%9'

select *
from sql_store.customers
-- where last_name like '%field%'
where last_name regexp 'field'

select *
from sql_store.customers
where (first_name regexp 'elka|ambur')
	or (last_name regexp 'ey$|on$')
	or (last_name regexp '^my|se')
    or (last_name regexp 'b[ru]')

select * from sql_store.orders
	where shipped_date is null 
    
order by用法
select * , unit_price*quantity as total_price
from sql_store.order_items	
where order_id = 2
order by total_price desc

limit用法
select * from sql_store.customers
limit 6,3
-- limit 练习
select * from sql_store.customers
order by points
limit 3

表自连接
select orders.* -- 为什么报错？
from sql_store.orders
join sql_store.customers 
	on orders.customer_id = customers.customer_id

select * 
-- 为什么报错？连接的每张表名前都加路径，不然无法识别
from sql_store.order_items as oi
join sql_store.products as p
	on oi.product_id = p.product_id
    
跨表连接
select * -- 为什么报错？连接的每张表名前都加路径，不然无法识别
from sql_store.order_items oi
join sql_inventory.products p
	on oi.product_id = p.product_id
    
表自连接
select *
from sql_hr.employees as e
join sql_hr.employees as m
	on e.report_to = m.employee
    
多表连接(相当于两表连接加一个join——on)
select 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name as status
from sql_store.orders as o
join sql_store.customers as c
	on o.customer_id = c.customer_id
join sql_store.order_statuses as os
	on os.order_status_id = o.status

select 
	p.date,
    p.amount,
    p.payment_method,
    c.name
from sql_invoicing.payments as p
join sql_invoicing.clients as c
	on p.client_id = c.client_id
join sql_invoicing.payment_methods as pm
	on p.payment_method =pm.payment_method_id

复合多主键连接条件——在表连接条件ON后面再加一个条件用and连接
隐式连接语法 select...from X , X , X 
						where X = X  

外连接：分两种左连接和右连接 返回ab集合的非交集
select 
	p.product_id,
	p.name,
    o.quantity
from sql_store.products as p
left join sql_store.order_items as o
		on p.product_id	= o.product_id			

 多表外连接
 select 
        o.order_date,
        o.order_id,
        c.first_name,
        sh.name as shipper,
        os.name as  status
 from sql_store.orders as o 
 join sql_store.customers as c
    on o.order_id = c.customer_id
left join sql_store.shippers as sh 
    on o.shipper_id = sh.shipper_id
    join sql_store.order_statuses as os 
        on o.status = os.order_status_id
自外连接
select 
    e.employee_id,
    e.first_name,
    m.first_name as manager
from sql_hr.employees as e
left join sql_hr.employees as m
    on e.reports_to = m.employee_id
USING代替ON
select 
    p.date,
    c.name as client,
    p.amount,
    pm.name
from sql_invoicing.payments p
left join sql_invoicing.payment_methods pm
    on p.payment_method = pm.payment_method_id
join sql_invoicing.clients c
    using(client_id)
自然连接nature join
交叉连接cross join 
select *
from sql_store.products p
cross join sql_store.shippers s -- 显式交叉
select *
from sql_store.products p ,sql_store.shippers s -- 隐式交叉

联合union 用来联合几段不同的查询 返回结果到同一张表的
select 
    customer_id,
    first_name,
    points,
    "Broze" as type
from sql_store.customers c
where points < 2000 
union
select 
    customer_id,
    first_name,
    points,
    "Silver" as type
from sql_store.customers c
where points >= 2000 and points <= 3000
union 
select 
    customer_id,
    first_name,
    points,
    "Gold" as type
from sql_store.customers c
where  points > 3000
order by first_name 