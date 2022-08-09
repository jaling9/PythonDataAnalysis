步骤1  导入数据
使用向导完成
步骤2  解决时间问题
str_to_date  字符串转时间

select 
STR_TO_DATE("April 9, 2013","%M %d, %Y");

select STR_TO_DATE("28-Jun-13","%d-%M-%Y");

在原有的数据表中增加一个字段用来存放时间

ALTER TABLE house
Add SaleDateConverted Date;
第一种日期
select SaleDate,
STR_TO_DATE(SaleDate,"%M %d, %Y"),SaleDateConverted  from house;
update house set SaleDateConverted  =  STR_TO_DATE(SaleDate, "%M %d, %Y") 

第二种日期

select SaleDate,
STR_TO_DATE(SaleDate,"%d-%M-%Y"),SaleDateConverted  from house;
update house set SaleDateConverted  =  STR_TO_DATE(SaleDate, "%d-%M-%Y") where 
SaleDateConverted is null ;

最终结果

select SaleDate
,SaleDateConverted  from house;

步骤3  
修复异常数据
空值数据 可以用delete 删除 
常规可行的方法 

但是我们可以试图进行深入挖掘

select ParcelID,count(*) from house
-- Where PropertyAddress is null
-- order by ParcelID
group by ParcelID
having count(*) >1

利用以下语句  发现有重复数据，而且有些数据含有地址信息，有些没有
Select 
a.ParcelID, a.PropertyAddress, 
b.ParcelID, b.PropertyAddress,
ISNULL(a.PropertyAddress),
isnull(b.PropertyAddress)
From house a
, house b
Where a.PropertyAddress is null
and a.ParcelID = b.ParcelID 
and a.UniqueID <> b.UniqueID

修复异常数据
update house a 
INNER JOIN house b 
on a.ParcelID = b.ParcelID 
and a.UniqueID <> b.UniqueID
set a.PropertyAddress= b.PropertyAddress
where a.PropertyAddress is null

步骤4  拆解字符串

拆成 Address, City

select "abc,123,777",
SUBSTRING_INDEX
('abc,123,777',',',1),
SUBSTRING_INDEX
('abc,123,777',',',-1),
SUBSTRING_INDEX(SUBSTRING_INDEX
('abc,123,777',',',2),',',-1)

扩充2个新的字段
ALTER TABLE house
Add Address Nvarchar(255);

ALTER TABLE house
Add City Nvarchar(255);

update house
set Address = SUBSTRING_INDEX
(PropertyAddress,',',1);

update house
set City= SUBSTRING_INDEX
(PropertyAddress,',',-1);


步骤5 解决数据中的 歧义问题

select DISTINCT(SoldAsVacant) from house

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From house
Group by SoldAsVacant
order by 2

select DISTINCT(
CASE 
    WHEN  SoldAsVacant='Y' THEN 'Yes'
    WHEN  SoldAsVacant='N' THEN 'No'
    ELSE SoldAsVacant
END)
 from house


Update house set SoldAsVacant=
CASE 
    WHEN  SoldAsVacant='Y' THEN 'Yes'
    WHEN  SoldAsVacant='N' THEN 'No'
    ELSE SoldAsVacant
END

步骤6 删除重复的数据行

select count(*) from house

一共有56477行数据

唯一编号结果也是56477 所以不可能有重复数据

重复数据有104条

Select ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference,count(*)
from house
group by 
ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
having count(*) > 1

----如果要删除重复数据  善于使用分组函数 会
获得神奇效果
56373
56477
104

create table house2b 
as 
Select *
From house
Group by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference

步骤7 导出数据

select * from house2b
INTO OUTFILE 'd:/data/backup2.csv'   
FIELDS ENCLOSED BY '"'   
TERMINATED BY ','   
ESCAPED BY '"'   
LINES TERMINATED BY '\r\n';  







CREATE TABLE  emp (
   depid CHAR(3)  NULL ,
   depname VARCHAR(20) NULL,
   peoplecount int NULL
) ENGINE=innoDB;


CREATE TABLE  emp (
   depid CHAR(3)  NULL ,
   depname VARCHAR(20) NULL,
   peoplecount int NULL
) ENGINE=innoDB;

CREATE TABLE  emp (
   depid CHAR(3)  NULL ,
   depname VARCHAR(20) not NULL,
   peoplecount int NULL,
    PRIMARY KEY (depid),
    unique(peoplecount)
) ENGINE=innoDB;

CREATE TABLE  emp4 (
               depid CHAR(3)  not NULL COMMENT'部门ID',
               depname VARCHAR(20) not NULL COMMENT'部门名称',
               peoplecount int NULL COMMENT'部门人数',
PRIMARY KEY (depid),
unique(peoplecount)
) 
ENGINE=innoDB;

CREATE TABLE game(
nId INT PRIMARY KEY AUTO_INCREMENT COMMENT '设置主键自增',
szName VARCHAR(128) COMMENT '游戏名字',
szPath VARCHAR(256) COMMENT '下载路径'
) COMMENT='表注释';

DROP TABLE  IF EXISTS emp;
CREATE TABLE  emp (
               depid CHAR(3)  not NULL COMMENT'部门ID',
               depname VARCHAR(20) not NULL DEFAULT'100' COMMENT'部门名称',
               peoplecount int NULL COMMENT'部门人数',
PRIMARY KEY (depid),
unique(peoplecount)
) 



ENGINE=innoDB;

RENAME TABLE emp TO empdep;

ALTER TABLE empdep
MODIFY depname VARCHAR(30);

ALTER TABLE empdep
ADD maname VARCHAR(10) not null;

ALTER TABLE empdep  modify depname varchar(30) after maname;

​ALTER TABLE empdep  DROP COLUMN maname;

ALTER TABLE empdep
DROP COLUMN maname;

















































