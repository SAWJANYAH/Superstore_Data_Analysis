superstore Table Datatypes
==========================
Row_ID             int64	
Order_ID          object	
Order_Date        object
Ship_Date         object
Ship_Mode         object
Customer_ID       object
Customer_Name     object
Segment           object
Country           object
City              object
State             object
Postal_Code        int64
Region            object
Product_ID        object
Category          object
Sub_Category      object
Product_Name      object
Sales            float64
dtype: object
---------------

-----			
db.py
-----

import mysql.connector

#connection
mydbss = mysql.connector.connect(HOST = 'localhost',USERNAME = 'bc2ad792',PASSWORD = 'Cab#22se',DATABASE = 'bc2ad792')

print(mydbss)

#create cursor
mycur = mydbss.cursor()

mycur.execute("SHOW TABLES")

for tname in mycur:
    print(tname)
--------------
import mysql.connector

myconn = mysql.connector.connect(HOST = 'localhost',USERNAME = 'bc2ad792',PASSWORD = 'Cab#22se',DATABASE = 'bc2ad792')

myconn.is_connected():
mycur=myconn.cursor()
mycur.execute("select database();")

print("MYSQL connected")


-------------------------			
Task1 = What percentage of total orders were shipped on the same date?
*****************************************
select (same_day_shipped / total_orders )*100 as percentage_sameday_shipped_orders from 
		(select count(*) as total_orders from superstore) total,
        (select count(*) same_day_shipped from superstore where ship_date = order_date) same_day_ship;	
=================
	percentage_sameday_shipped_orders
	6.2182		
--------------
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0076 seconds.)

select (same_day_shipped / total_orders )*100 as percentage_sameday_shipped_orders from 
		(select count(*) as total_orders from superstore) total,
        (select count(*) same_day_shipped from superstore where ship_date = order_date) same_day_ship


-------
6.2182	

*****************************************	  
Task2. Name top 3 customers with highest total value of orders.
group by customer , sum of sales##
*****************************
select customer_id, sum(sales) as Total_value_of_sales from superstore 
group by customer_id order by Total_value_of_sales DESC LIMIT 3;
----------------------------------------
Task3- Find the top 5 items with the highest average sales per day.

============
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  4 (5 total, Query took 0.0215 seconds.)

select product, avgsales as Highest_sales,order_date from 
    (select any_value(product_name) as product, avg(sales) as avgsales,order_date 
	from superstore group by order_date order by avgsales DESC) avgs Limit 5

----------------
product	Highest_sales	order_date	
Chromcraft Bull-Nose Wood Oval Conference Tables &...	4297.644042969	2016-01-28	
Kensington 6 Outlet Guardian Standard Surge Protec...	2636.138742174	2017-10-02	
Hewlett-Packard Deskjet 6540 Color Inkjet Printer	2555.156033516	2015-03-18	
Hewlett Packard LaserJet 3310 Copier	2399.959960938	2018-07-24	
DAX Natural Wood-Tone Poster Frame	1852.008492470	2018-03-23	

---------------------------------------------------------
Task4 - Write a query to find the average order value for each customer, and rank the customers by their average order value.
----------------------------------------
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 - 24 (787 total, Query took 0.0145 seconds.)

select Customer_id, Avg_sales, (row_number() over(order by Avg_sales DESC)) as Rankno from
      (select avg(sales) as Avg_sales,customer_id from superstore group by customer_id) avgsales


Customer_id	Avg_sales	Rankno	
GT-14635	4083.709991455	1	
TC-20980	1853.029719496	2	
MW-18235	1751.291951497	3	
SM-20320	1751.185748134	4	
TA-21385	1459.561986446	5	
CC-12370	1212.782353735	6	
HL-15040	1170.299787521	7	
BS-11365	1166.850301901	8	
SH-20635	1048.196014404	9	
AB-10105	985.897803477	10	
CM-12385	895.402016330	11	
JR-15700	863.880004883	12	
MJ-17740	851.652826582	13	
YC-21895	847.141004403	14	
PM-19135	841.093462944	15	
RB-19360	839.852164374	16	
CM-12655	838.166859899	17	
AR-10540	822.650998473	18	
TP-21415	821.876771291	19	
TS-21370	792.783392747	20	
KC-16540	781.652421951	21	
AC-10450	779.661990643	22	
SC-20095	771.443562931	23	
KW-16435	770.344393921	24	
TB-21400	733.504722335	25	

-----------------------------
Task5 - Give the name of customers who ordered highest and lowest orders from each city.##
--------------------
select city as City,any_value(customer_name) as Customer, max(No_of_Orders) as Highest_Orders, 
min(No_of_Orders) as Lowest_orders from (select count(order_id) as No_of_Orders, customer_name, city 
from superstore group by city,customer_name) as calorders group by city
--------------------------------
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 - 49 (506 total, Query took 0.0324 seconds.)

select city as City,any_value(customer_name) as Customer, max(No_of_Orders) as Highest_Orders, min(No_of_Orders) as Lowest_orders from  (select count(order_id) as No_of_Orders, customer_name, city from superstore group by city,customer_name) as calorders group by city


City	Customer	Highest_Orders	Lowest_orders	
Los Angeles	Darrin Van Huff	9	1	
Fort Lauderdale	Sean O Donnel	2	1	
Concord	Andrew Allen	3	1	
Fort Worth	Harold Pawlan	4	1	
Madison	Pete Kriz	2	1	
West Jordan	Alejandro Grove	1	1	
San Francisco	Zuschuss Donatelli	6	1	
Philadelphia	Sandra Flanagan	12	1	
Orem	Emily Burns	3	1	
Houston	Matt Abelman	8	1	
Naperville	Linda Cazamias	3	1	
Melbourne	Erin Smith	1	1	
Eagan	Odella Nelson	3	2	
Westland	Patrick O Donnel	8	1	
Dover	Lena Hernandez	3	1	
New Albany	Darren Powers	4	4	
New York City	Janet Molinari	14	1	
Troy	Ted Butterfield	7	1	
Chicago	Paul Stevenson	10	1	
Springfield	Karen Daniels	12	1	
Jackson	Tracy Blumstein	6	1	
Memphis	Joel Eaton	7	1	
Decatur	Stewart Carmichael	5	1	
Durham	Julie Creighton	3	1	
Columbia	Patrick O Donnel	9	1	
Rochester	Paul Gonzalez	5	1	
Minneapolis	Karl Braun	4	1	
Aurora	Lena Cacioppo	4	1	
Charlotte	Janet Martin	6	1	
Orland Park	Pete Armstrong	1	1	
Columbus	Ryan Crowe	8	1	
Seattle	Dave Kipp	11	1	
Wilmington	Steven Cartwright	5	1	
Bloomington	Philip Fox	4	1	
Roseville	Lena Creighton	7	1	
Independence	Sandra Glassco	1	1	
Newark	Maureen Gastineau	6	1	
Franklin	Justin Ellison	5	1	
Scottsdale	Tamara Willingham	4	1	
San Jose	Stephanie Phelps	9	1	
Edmond	Nora Paige	2	2	
Carlsbad	Ruben Dartt	4	1	
Monroe	Robert Marley	5	1	
Fairfield	Sally Knutson	7	1	
Grand Prairie	Alice McCarthy	3	1	
Redlands	Mary Zewe	9	1	
Hamilton	Cassandra Brandow	2	1	
Akron	Maria Bertelson	5	1	
Denver	Bruce Stewart	7	1	
Dallas	Logan Currie	8	1	

------------------------------
Task6- What is the most demanded sub-category in the west region?

select s1.sub_category as Demanded_Subcategory from (select count(sub_category) as subcat_count, sub_category from superstore 
      where region='West' group by sub_category order by subcat_count DESC) as s1 LIMIT 1;  
	  
localhost/bc2ad792/s1/		https://projects.hicounselor.com/zootopia/index.php?db=bc2ad792&table=superstore&target=tbl_sql.php
 Showing rows 0 -  0 (1 total, Query took 0.0106 seconds.)

select s1.sub_category as Demanded_Subcategory from (select count(sub_category) as subcat_count, sub_category from superstore 
      where region='West' group by sub_category order by subcat_count DESC) as s1 LIMIT 1


Demanded_Subcategory
Binders	
--------------	  
Task7 - Which order has the highest number of items? And which order has the highest cumulative value?

select any_value(s1.orderid) as OrderID,max(count_prodid) as Highest_product_items from 
(select count(product_id) as count_prodid,order_id as orderid from superstore group by orderid) as s1; 

localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0196 seconds.)

select any_value(s1.orderid) as OrderID,max(count_prodid) as Highest_product_items from (select count(product_id) as count_prodid,order_id as orderid from superstore group by orderid) as s1


order_id Highest_product_items
CA-2017-138688	14	
====================================
select any_value(s2.order_id) as Orderid, max(s2.sale_value) as Highest_sale from 
  (select sum(sales) as sale_value, order_id from superstore group by order_id order by sale_value desc) s2;
  
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0221 seconds.)

select any_value(s2.orderid) as Orderid, max(s2.sale_value) as Highest_sale from 
  (select sum(sales) as sale_value, order_id as orderid from superstore group by order_id order by sale_value desc) s2


order_id   Highest_sale
CA-2015-145317	23661.22845	
  
--------------------
Task8 - Which order has the highest cumulative value?
--
select any_value(s2.order_id) as Orderid, max(s2.sale_value) as Highest_sale from 
  (select sum(sales) as sale_value, order_id from superstore group by order_id order by sale_value desc) s2;
  
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0221 seconds.)

select any_value(s2.order_id) as Orderid, max(s2.sale_value) as Highest_sale from 
  (select sum(sales) as sale_value, order_id from superstore group by order_id order by sale_value desc) s2


order_id   Highest_sale
CA-2015-145317	23661.22845	

--------------------------
Task 9 - Which segment’s order is more likely to be shipped via first class?
-----
select count(segment) as Highest_segment, segment from superstore where ship_mode= 'First Class' group by segment order by Highest_segment desc Limit 1;  
 
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/db_sql.php?db=bc2ad792
 Showing rows 0 -  0 (1 total, Query took 0.0077 seconds.)

select count(segment) as Highest_segment, segment from superstore where ship_mode= 'First Class' group by segment order by Highest_segment desc Limit 1

Highest_segment segment
697	Consumer	
------------------------
Task 10-Which city is least contributing to total revenue?
select city, sum(sales) as Total_sales from superstore group by city order by total_sales ASC LIMIT 1;
---------------
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0112 seconds.)

select city, sum(sales) as Total_sales from superstore group by city order by total_sales ASC LIMIT 1;

Abilene	1.39200	
----------------------
Task 11 - What is the average time for orders to get shipped after order is placed?
select avg(DATEDIFF(ship_date, order_date)) as Avg_time_to_ship from superstore;
-------------------------------
localhost/bc2ad792/superstore/		https://projects.hicounselor.com/zootopia/tbl_sql.php?db=bc2ad792&table=superstore
 Showing rows 0 -  0 (1 total, Query took 0.0093 seconds.)

select avg(DATEDIFF(ship_date, order_date)) as Avg_time_to_ship from superstore;


Avg_time_to_ship
3.8253	

-------------------------------

Task 12 - Which segment places the highest number of orders from each state and which segment places the largest individual orders from each state?
-----------------------
select t.state, t.segment, t3.max_order from superstore t
join
	(select t1.state, max(t2.tot_orders) as max_order from superstore t1, 
		(select state, segment, count(order_id) as tot_orders from superstore group by state, segment order by state ) t2
	where t1.state = t2.state and t1.segment = t2.segment
	group by t1.state
	order by t1.state) t3
on t.state = t3.state
group by t.state, t.segment
having count(t.order_id) = t3.max_order
order by t.state, t.segment desc
------------------
select s2.state,s2.segment,s1.max_sales from superstore s2
join
 (select state,max(sales) as max_sales from superstore group by state order by state) s1
on s2.state = s1.state
where s2.sales = s1.max_sales order by s2.state; 
-------------------

Task 13 - Find all the customers who individually ordered on 3 consecutive days where each day’s total order was more than 50 in value. **
## There are no customers who ordered consecutively Three days##
--------------------------
select t1.customer_id, t1.tot_sales,t2.tot_sales,t3.tot_sales, t1.order_date, t2.order_date, t3.order_date from 
(select customer_id,order_date, sum(sales) as tot_sales from superstore group by customer_id,order_date order by customer_id) t1 
JOIN (select customer_id,order_date, sum(sales) as tot_sales from superstore group by customer_id,order_date order by      customer_id) t2 on t2.order_date= DATE_ADD(t1.order_date,INTERVAL 1 DAY) and t1.customer_id=t2.customer_id 
JOIN (select customer_id,order_date, sum(sales) as tot_sales from superstore group by customer_id,order_date order by customer_id) t3 on t3.order_date= DATE_ADD(t1.order_date,INTERVAL 2 DAY) and t1.customer_id=t3.customer_id 
group by t1.customer_id,t1.order_date,t2.order_date,t3.order_date 
having t1.tot_sales > 50 and t2.tot_sales > 50 and t3.tot_sales > 50

-------------------------
select t1.cust_id, t1.tot_sales as Day1_sales,t2.tot_sales as Day2_sales, t1.order_date as Day1_orderdate, t2.order_date as Day2_orderdate
from (select cust_id,order_date, sum(sales) as tot_sales from superstore group by cust_id,order_date order by cust_id) t1
JOIN (select cust_id,order_date, sum(sales) as tot_sales from superstore group by cust_id,order_date order by cust_id) t2 
	on t2.order_date= DATE_ADD(t1.order_date,INTERVAL 1 DAY) and t1.cust_id=t2.cust_id
group by t1.cust_id,t1.order_date,t2.order_date
having t1.tot_sales > 50 and t2.tot_sales > 50
------------------------------
cust_id  Day1_sales Day2_sales Day1_orderdate Day2_orderdate
AR-10825	361.04401	1629.71202	2018-07-20	2018-07-21
JH-15430	59.91300	52.69600	2018-11-19	2018-11-20
KB-16405	697.52500	56.13600	2018-09-03	2018-09-04
KH-16630	85.05600	163.39200	2018-09-10	2018-09-11
ML-17755	663.93597	629.64001	2018-11-30	2018-12-01
RB-19435	111.79000	1272.70398	2015-11-24	2015-11-25
SH-20395	409.30401	1395.67300	2015-11-02	2015-11-03
---------------------------------------

Task 14 -Find the maximum number of days for which total sales on each day kept rising.** 
---------------------------
select count(*) as 'Max Days when Sales raised' from
(select t1.order_date,t1.sum_sales, LAG(t1.sum_sales) over(order by t1.order_date) as prev_sales from superstore t2,
(select sum(sales) as sum_sales, order_date from superstore group by order_date order by order_Date) t1
where t2.order_date = t1.order_date 
group by t2.order_date) t3 where sum_sales > prev_sales

Max Days when sales raised
548
----------------------