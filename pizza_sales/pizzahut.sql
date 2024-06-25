CREATE database PIZZAHUT;
SELECT * FROM PIZZAHUT.PIZZAS;
SELECT * FROM PIZZAHUT.PIZZA_TYPES;
USE PIZZAHUT;
CREATE TABLE ORDERS(
ORDER_ID INT NOT NULL,
ORDER_DATE DATE NOT NULL,
ORDER_TIME TIME NOT NULL,
PRIMARY KEY(ORDER_ID));
SELECT * FROM PIZZAHUT.ORDERS;
CREATE TABLE ORDER_DETAILS(
ORDER_DETAILS_ID INT NOT NULL,
ORDER_ID INT NOT NULL,
PIZZA_ID TEXT NOT NULL,
QUANTITY INT NOT NULL,
PRIMARY KEY(ORDER_DETAILS_ID));
select * from pizzahut.order_details;
use pizzahut;
select count(order_id) as total_orders
from orders;
select sum(price) as total_revenue from pizzas;



select pizza_types.name,pizzas.price
from pizza_types join pizzas
on  pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;

select quantity ,count(order_details_id)
from order_details
group by quantity;

select pizzas.size,count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size
order by order_count desc;

select pizzas.pizza_type_id,order_details.quantity 
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
;

select pizza_types.name,sum(order_Details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by quantity desc
limit 5;
use pizzahut;

select hour(order_time ) as hours,count(order_id)
from orders
group by hours;

select category,count(name)
from pizza_types
group by category ;
select round(avg(quantity),2) from
(select orders.order_date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id=order_details.order_id
group by orders.order_date) as order_quantity;

select pizza_types.name ,
sum(order_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;


select pizza_types.category,
(sum(order_details.quantity*pizzas.price) /
(select 
round(sum(order_details.quantity*pizzas.price),2)
from pizzahut.order_details join pizzahut.pizzas
on pizzas.pizza_id=order_details.pizza_id))*100 as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by revenue ;

