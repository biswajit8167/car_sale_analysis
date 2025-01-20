create database car;
use car;
select* from car_sales;

---1.What is the total revenue generated from all car sales?----

SELECT SUM(sale_price) AS Total_Revenue
FROM car_sales;

---	2.How many cars were sold during the year?--
select count(*) as total_sold_cars, Car_Year,  Car_Model
from car_sales
group by Car_Model,Car_Year
order by car_model desc,car_year asc;
 
 ----3.	Which salesperson generated the highest revenue?----

 select salesperson, sum(sale_price) as highest_revenue
 from car_sales
 group by Salesperson, Sale_Price
 order by highest_revenue desc;

 ---4.	What is the total commission earned by all salespeople?---
 select sum(commission_earned) as total_commission_earned
 from car_sales_data;

 ---5.o	What is the average sale price of a car?--

 select avg(sale_price)as avg_sale_price, car_model
 from car_sales
 group by car_model
 order by avg_sale_price desc;

 ---6.o	How much revenue was generated in each month?--
 

 SELECT 
    FORMAT(Date, 'yyyy-MMMM') AS Sale_Month,
    SUM(Sale_Price) AS Total_Revenue
FROM car_sales
GROUP BY FORMAT(Date, 'yyyy-MMMM')
ORDER BY Sale_Month;

--7.o	Which customer spent the most money on car purchases?--
select customer_name, sum(sale_price) as money_spend_on_car
from car_sales
group by customer_name, sale_price
order by money_spend_on_car desc;

--9 o	How many cars of each make were sold, and what was the total revenue for each make?--

select car_make, count(*) as total_car_sold, sum(sale_price) as total_revenue
from car_sales
group by car_make
order by total_car_sold;

---10	How much commission did each salesperson earn---
select sum(commission_earned) as total_commission_earned , salesperson
from car_sales
group by salesperson
order by total_commission_earned desc;

---11.o	How many cars of each manufacturing year were sold?--
select count(*) as total_sold, car_year
from car_sales
group by car_year
order by car_year;

--12.o	Which day recorded the highest total sales?---

SELECT 
    FORMAT(Date, 'yyyy-dddd') AS Sale_Month,
    SUM(Sale_Price) AS Total_Revenue
FROM car_sales
GROUP BY FORMAT(Date, 'yyyy-dddd')
ORDER BY total_revenue desc;

---13.o	Which sale earned the highest commission for a salesperson?---

select sale_price,sum(commission_earned) as highest_commission, salesperson
from car_sales
group by salesperson, sale_price
order by highest_commission desc;

---14.o	What is the total revenue generated in each quarter of the year?---


SELECT 
    CONCAT('Q', DATEPART(QUARTER, Date), ' ', YEAR(Date)) AS Quarter,
    SUM(Sale_Price) AS Total_Revenue
FROM car_sales
GROUP BY YEAR(Date), DATEPART(QUARTER, Date)
ORDER BY YEAR(Date), DATEPART(QUARTER, Date);

---15. Who are the top 3 salespeople based on total revenue generated?

select top 3 salesperson, sum(sale_price) as total_revenue
from car_sales
group by sale_price,salesperson
order by total_revenue desc 
;

---16.Which salesperson generated the highest total revenue during the year?--

select top 1 salesperson,date,sum(sale_price) as highest_total_revenue
from car_sales
group by salesperson, Sale_Price,date
order by highest_total_revenue desc;

--17.What is the average sale price of cars grouped by car make and model?

select avg(sale_price) as avg_price,car_make,car_model
from car_sales
group by car_make,car_model
order by avg_price desc;

---18.Which month of the year generated the highest revenue?

SELECT 
   TOP 1 FORMAT(Date, 'yyyy-MMM') AS Sale_Month,
    SUM(Sale_Price) AS Total_Revenue
FROM car_sales
GROUP BY FORMAT(Date, 'yyyy-MMM')
ORDER BY total_revenue desc;

---19.Which car model generated the highest revenue for each year?

select top 1 car_model, sum(sale_price) as highest_revenue,format(date,'yyyy') as year
from car_sales
group by Car_Model,sale_price,format(date,'yyyy')
order by sale_price desc;

---20.What is the total revenue generated by each salesperson from cars priced above the average sale price?
with avg_price as(select avg(sale_price) as avg_sale_price from car_sales

)
select salesperson, sum(sale_price) as total_revenue
 from car_sales
 where Sale_Price>(select avg_sale_price from avg_price)
 group by salesperson, sale_price
 order by total_revenue desc;
 ---alternate query---
 select salesperson, sum(sale_price) as total_revenue
 from car_sales
 where Sale_Price>(select avg(sale_price) from car_sales)
 group by salesperson, sale_price
 order by total_revenue desc;

 ---21.What is the total revenue generated by each salesperson, and their rank based on total revenue?---

 select salesperson, sum(sale_price) as total_revenue ,
 rank() over (order by sum(sale_price) desc) as revenue_rank
 from car_sales
 group by salesperson, sale_price
 order by revenue_rank;

 ---22.What is the cumulative revenue generated by each salesperson over time?
 SELECT 
    Salesperson,
    Date,
    Sale_Price,
    SUM(Sale_Price) OVER (PARTITION BY Salesperson ORDER BY Date) AS Cumulative_Revenue
FROM car_sales
ORDER BY Salesperson, Date;

--23.Which sales generated commissions above the average commission earned for their respective car make?

select  sale_price,salesperson, commission_earned, Car_Make, car_model
from car_sales
where Commission_Earned>(select avg(Commission_Earned) from car_sales);