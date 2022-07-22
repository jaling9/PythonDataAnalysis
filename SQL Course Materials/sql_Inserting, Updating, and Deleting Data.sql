插入单行数据
insert into sql_store.customers (
    first_name,
    last_name,
    birth_date,
    address,
    city,
    state) 
values (
    'john',
    'smith',
    '1990-01-01',
    'adrress',
    'city',
    'ca')
插入多行数据
insert into sql_store.products (
    name,
    quantity_in_stock,
    unit_price)
values ('product1','10',1.95),
       ('product2','10',1.95),
       ('product3','10',1.95)
插入分层结构
insert into sql_store.orders (
        customer_id,
        order_date,
        status)
values (1,'2019-01-01',1)
insert into sql_store.order_items
values (last_insert_id(),1,1,2.5),-- 分层结构就是一个订单买了两件东西，包含关系
        (last_insert_id(),2,1,3.5)
创建表复制 
-- create table as 或者 insert into + 子查询
insert into sql_store.orders_archvied 
select * 
from sql_store.orders
where shipper_id is not null

create table sql_invoicing.invoices_archvied as 
select 
    c.name,
    c.phone,
    i.invoice_total,
    i.payment_total,
    i.due_date
from sql_invoicing.invoices as i
join sql_invoicing.clients as c
using(client_id)
where payment_date is not null 

更新一行 update...set...
UPDATE 表 
SET 要修改的字段 = 具体值/NULL/DEFAULT/列间数学表达式 （修改多个字段用逗号分隔）
WHERE 行筛选

更新多行 update...set...where + select子查询
SELECT client_id 
FROM clients
WHERE state IN ('CA', 'NY')

删除行 delete...from...where + select 子查询
DELETE FROM 表 
WHERE 行筛选条件
（当然也可用子查询）
（若省略 WHERE 条件语句会删除表中所有记录（和 TRUNCATE 等效？）

聚合函数
select 
    max(invoice_total) as highest,
    min(invoice_total) as lowest,
    avg(invoice_total) as average,
    sum(invoice_total*1.1) as total,
    count(*) as total_records
from sql_invoicing.invoices
where invoice_date > '2019-07-01'

select 
    'first half of 2019' as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_we_expect
from sql_invoicing.invoices
where payment_date between '2019-01-01' and '2019-07-01'
union 
select 
    'secord half of 2019' as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_we_expect
from sql_invoicing.invoices
where payment_date between '2019-07-01' and '2019-12-31'
union 
select 
    'total' as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_we_expect
from sql_invoicing.invoices
where payment_date between '2019-01-01' and '2019-12-31'

Group by用法
select 
    client_id,
    sum(invoice_total) as total_sales
from sql_invoicing.invoices
where invoice_date >= '2019-07-01'
group by client_id
order by total_sales desc

select 
    c.city,
    c.state,
    sum(invoice_total) as total_sales
from sql_invoicing.invoices as i
join sql_invoicing.clients as c
using(client_id)
group by state , city

-- execers
select 
    p.date,
    pm.name as payment_method,
    sum(p.amount) as total_payments
from sql_invoicing.payments as p
join sql_invoicing.payment_methods as pm
    on p.payment_id = pm.payment_method_id
group by date,payment_method 
order by date

having子句用法 代替where 用在group by之后
select 
    client_id,
    sum(invoice_total) as total_sales,
    count(*) as number_of_invoices
from sql_invoicing.invoices
group by client_id
having total_sales > 500 and number_of_invoices > 5

-- exerices
select 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.state,
    sum(quantity*unit_price) as total_payments
from sql_store.orders o
join sql_store.customers c
    using(customer_id)
join sql_store.order_items oi
    using(order_id)
group by 
    c.customer_id,
    c.first_name,
    c.last_name
having state = 'VA' and total_payments > 100 
order by total_payments desc

ROLLUP 运算符 -- 1.进行汇总 2.只对聚合计算的部分汇总3.对每个组进行汇总
select 
    client_id,
    sum(invoice_total) as total_sales,
    count(*) as number_of_invoices
from sql_invoicing.invoices
group by client_id with rollup

子查询
select *
from sql_hr.employees
where salary > (
    select 
    avg(salary)
    from sql_hr.employees
)

in运算符
select *
from sql_store.products
where product_id not in(
    select distinct product_id
    from sql_store.order_items
)

select *
from sql_invoicing.clients c
where client_id not in (
    select distinct client_id
    from sql_invoicing.invoices i
)

子查询和连接哪个好？选择时效性和易读性好的
select  -- 三层子查询嵌套
    customer_id,
    first_name,
    last_name
from sql_store.customers
where customer_id in (  -- 为什么这里只能用in，不能用 = 呢？
    select customer_id 
    from sql_store.orders
    where order_id in (
        select order_id
        from sql_store.order_items
        where product_id = 3 )
    )

select distinct   -- 使用连接
    c.customer_id,
    c.first_name,
    c.last_name
from sql_store.orders o
join sql_store.customers c
    using(customer_id)
join sql_store.order_items oi
    using(order_id)
where product_id = 3

all 关键字
USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > (
    SELECT MAX(invoice_total)
    FROM invoices
    WHERE client_id = 3
)

USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
    SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)

any关键词
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id IN (  -- 或 = ANY ( 
    -- 子查询：有2次以上发票记录的顾客
    SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >= 2
)

USE sql_hr;
-- 相关子查询 与普通子查询不同的地方在于相关子查询是查询同一个表里的数据，普通子查询是查询不同的表的数据
select *
from sql_hr.employees e
where salary > (
	select avg(salary)
    from sql_hr.employees 
    where e.office_id = office_id -- 筛选位于同一部门的员工 
                                  -- 外面的员工办公室=里面员工的办公室
    -- 这里狠重要->要求被选择出来的员工的部门跟第一个select的员工一样
)

use sql_invoicing;
select *
from invoices i
where invoice_total > (
	select avg(invoice_total)
    from invoices 
    where i.client_id = client_id
)
用其他方法实现
use sql_invoicing;
select *
from invoices
group by client_id
having invoice_total > (
	select avg(invoice_total)
    from invoices
) 
-- 留个问题以后再思考，为什么这段代码实现不了
exists语句
exists 语句

use sql_store;
select *
from products p						-- 大范围筛选小范围
where not exists (					-- 理解成没被卖掉的产品
	select product_id
    from order_items
    where p.product_id = product_id -- 返回被订购的订单
)
用in来写
use sql_store;
select *
from products p
where product_id not in (
	select product_id
    from order_items
)
用join来写
use sql_store;
select *
from products p
left join order_items oi
	using(product_id)
where order_id is null

在select中使用子查询
use sql_invoicing;
select 
    invoice_id,
    invoice_total,
    (select avg(invoice_total) from invoices) as avg1 ,
    (invoice_total - (select avg1)) as differice
from invoices

use sql_invoicing;
select 
    client_id,
    name ,
    (select sum(invoice_total) 
    from invoices i
    where i.client_id= c.client_id) as invoice_sales, -- 需要分组计算，所以要写相关子查询表达式
    (select avg(invoice_total)from invoices) as average , -- 不需要分组，所以得出来是一个值
    (select invoice_sales - average) as diffrece 
    -- 重中之重 select后面不能写别名
    /* 如前所述，引用同级的列别名，要加括号和 SELECT，
    和前两行子查询的区别是，引用同级的列别名不需要说明来源，
    所以没有 FROM …… */
from clients c

用group by实现上面的功能
use sql_invoicing;
select 
    c.client_id,
    c.name ,
    sum(invoice_total) as invoice_sales
from clients c
left join invoices i
    on i.client_id =c.client_id
group by client_id
-- 暂时无法实现


在from中使用子查询
select *
from ( select 
        client_id,
        name ,
        (select sum(invoice_total) 
        from invoices i
        where i.client_id= c.client_id) as invoice_sales, -- 需要分组计算，所以要写相关子查询表达式
        (select avg(invoice_total)from invoices) as average , -- 不需要分组，所以得出来是一个值
        (select invoice_sales - average) as diffrece 
    from clients c ) as sales_suammary
where invoice_sales is not null

-------------------------------------------------------------
视图 CREATE VIEW ... AS 

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

如果一个视图的原始查询语句中没有如下元素：
1. DISTINCT 去重
2. GROUP BY/HAVING/聚合函数 (后两个通常是伴随着 GROUP BY 分组出现的)
3. UNION 纵向连接
则该视图是可更新视图（Updatable Views），可以增删改，否则只能查。
USE sql_invoicing;

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
    /* 这里有个小技巧，要插入表中的多列列名时，
    可从左侧栏中连选并拖入相关列 */
    invoice_id, 
    number, 
    client_id, 
    invoice_total, 
    payment_total, 
    invoice_date,
    invoice_total - payment_total AS balance,  -- 新增列
    due_date, 
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
/* 这里不能用列别名balance，会报错说不存在，
必须用原列名的表达式，这还是执行顺序的问题
之前讲WHERE和HAVING作为事前筛选和事后筛选的区别时提到过 */

在视图的原始查询语句最后加上 WITH CHECK OPTION 可以防止执行那些会让视图中某些行（记录）消失的修改语句。

--------------------------------------------------------
存储过程

DELIMITER $$
CREATE PROCEDURE  get_clients()
BEGIN
SELECT * FROM sql_invoicing.clients;

END$$
DELIMITER ;
-----------------------------------------------------
DELIMITER $$
-- delimiter n. 分隔符

    CREATE PROCEDURE 过程名()  
        BEGIN
            ……;
            ……;
            ……;
        END$$

DELIMITER ;
------------------------------------------------------
这写的啥？
@DELIMITER $$
CREATE PROCEDURE get_invoice_with_balance()
BEGIN
SELECT 
    * ,
    invoice_total - payment_total AS balance
FROM sql_invoicing.invoices
GROUP BY invoice_id 
HAVING invoice_total - payment_total > 0
ORDER BY balance DESC; -- 加分号
END$$ -- 加美元符号
@DELIMITER ;
---------------------------------------------------
使用MySQL工作台创建存储过程
----------------------------------------------------
删除存储过程 
USE sql_invoicing;
DROP PROCEDURE IF EXISTS get_clients;
-- 注意加上【IF EXISTS】，以免因为此过程不存在而报错
DELIMITER $$
    CREATE PROCEDURE get_clients() -- creat procrdure写在DEMILITER里面 删除写在前面alter
        BEGIN
            SELECT * FROM clients;
        END$$
DELIMITER ;
CALL get_clients();

------------------------------------------------
参数
USE sql_invoicing;
drop procedure IF exists get_clients_by_state;
-- 上面这句是保证不会创建重复内容
DELIMITER $$
    CREATE PROCEDURE get_clients_by_state(state char(2))
        BEGIN
            SELECT * FROM clients c -- 这是保证参数得state和订单state一样
            where c.state = state ;
        END$$
DELIMITER ;
CALL get_clients();

--------------------------------------------------
@DEMILITER $$
CREATE procedure get_invoices_by_client(payment_total DECIMAL(9,2))
BEGIN 
    SELECT * 
    FROM sql_invoicing.clients c
    JOIN sql_invoicing.invoices i
    USING(client_id)
    WHERE i.payment_total = payment_total;
END$$
@DEMILITER ;
---------------------------------------------------
CREATE PROCEDURE `get_invoices_by_client`
 (
	client_id int -- 不要忘记数据类型
 )
BEGIN
	SELECT *
    FROM sql_invoicing.invoices i
    WHERE i.client_id = client_id;
END
---------------------------------------------------

给参数配置默认值
USE sql_invoicing;
drop procedure IF exists get_clients_by_state;
-- 上面这句是保证不会创建重复内容
DELIMITER $$
    CREATE PROCEDURE get_clients_by_state(state char(2))
        BEGIN
            IF state is null then 
            set state = 'CA' ;
            end if ;
            SELECT * FROM clients c 
            where c.state = state ;
            /*
            如果要返回多个结果
            IF state is null then 
            SELECT * FROM clients
            ELSE SELECT * FROM clients c 
            where c.state = state ;
            END IF;
            */
            /*
            还可以使用IFNULL函数写法实现
            SELECT * FROM clients c 
            where c.state =IFNULL(state,c.client) ;  -- 这个看起来比较专业 嗯
            END IF;
            */
        END$$
DELIMITER ;
CALL get_clients();
---------------------------------------------------------------------------
练习原始写法报错

@DEMILITER $$
CREATE PROCEDURE get_payments
(
    client_id INT,
    payment_method_id TINYINT 
)
    BEGIN 
        USE sql_invoicing;
        SELECT *
        FROM payments p
        WHERE p.client_id = IFNULL(client_id,p.client_id) 
        AND p.payment_method = IFNULL(payment_method_id,p.payment_method); 
    END$$
@DEMILITER ;
-----------------------------------------------------------------
创建存储过程写法
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payments`( 
client_id INT,
payment_method_id TINYINT 
)
BEGIN
	SELECT *
        FROM payments p
        WHERE p.client_id = IFNULL(client_id,p.client_id) 
        AND p.payment_method = IFNULL(payment_method_id,p.payment_method); 
        -- IFNULL()里面第一个参数是对应输入框里的参数名称 method不是moehon实名制批评自己
END

----------------------------------------------------------------------------------
参数验证
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_payment`(
	invoice_id INT,
    payment_amount decimal(9,2),
    payment_date date
)
BEGIN
	if payment_amount <= 0 then
		signal sqlstate '22003'
			set message_text = 'invalid payment amount'; -- 不要忘记分号
	end if ; -- 不要忘记分号
	update invoices i
    set 
		i.payment_total = payment_amount,
        i.payment_date = payment_date
        where i.invoice_id = invoice_id; -- 易错点，是invoce_id 不是payment_id
END
------------------------------------------------------------
输出参数
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unpaid_invoices_for_clients`(
	client_id int,
    out invoice_count int,
    out invoice_total decimal(9,2)
 )
BEGIN
	select count(*),
    sum(invoice_total)
    into invoice_count ,invoice_total
    from invoices i
    where i.client_id = client_id 
		and payment_total = 0;
END
--------------------------------------------------------------
本地变量
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_risk_factor`()
BEGIN
    -- 声明三个本地变量，可设默认值
    DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;

    -- 用SELECT得到需要的值并用INTO传入invoices_total和invoices_count
    SELECT SUM(invoice_total), COUNT(*)
    INTO invoices_total, invoices_count
    FROM invoices;

    -- 用SET语句给risk_factor计算赋值
    SET risk_factor = invoices_total / invoices_count * 5;

    -- 展示最终结果risk_factor
    SELECT risk_factor;        
END
--------------------------------------------------------------
函数
1. 参数设置和body内容之间，有一段确定返回值类型以及函数属性的语句段
RETURNS INTEGER -- 返回结果
DETERMINISTIC -- 唯一的值
READS SQL DATA -- 只读
MODIFIES SQL DATA -- 修改
……
2. 最后是返回（RETURN）值而不是查询（SELECT）值
RETURN IFNULL(risk_factor, 0);

3.DROP FUNCTION [IF EXISTS] 函数名 -- 注意把函数保存到SQL文件
练习
CREATE DEFINER=`root`@`localhost` FUNCTION `get_risk_factor_for_client`(
	client_id int
) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT SUM(invoice_total), COUNT(*)
    INTO invoices_total, invoices_count
    FROM invoices i
    WHERE i.client_id = client_id;
    -- 注意不再是整体risk_factor而是特定顾客的risk_factor;[非常重要]

    SET risk_factor = invoices_total / invoices_count * 5;
	
    return ifnull(risk_factor,0); -- 注意这里返回的是risk_factor
END
-----------------------------------------------------------------------------
触发器