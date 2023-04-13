use Project;
select * from inventory_data;
select * from transaction_data;

#1.top 3 products having the most number of transactions:
select inventory_data.product_type,count(transaction_data.transaction_id) 
as TOTAL_TRANSACTION
from inventory_data
INNER join transaction_data on
inventory_data.product_id=transaction_data.product_id
group by product_type
order by sum(transaction_id) DESC
limit 3;

#2.FIND TOP 10 SNACKS PRODUCTS HAVING MOST NUMBER OF TRANSACTIONS:
SELECT i.product_name,COUNT(t.transaction_id) as tot
from  inventory_data i
join  transaction_data t on i.product_id=t.product_id
where product_type='snacks'
group by product_name
order by count(transaction_id )DESC
limit 10;

#3.5 Transactions which had the most number of products 
select count(i.product_type)as prod,  t.transaction_id as transac
from inventory_data i
join transaction_data t on i.product_id=t.product_id
group by transaction_id
order by count(product_type) desc
limit 5;

#4.Sum of unit price,all unique products,find of products which have sum of
#unit price greater than 150 dollars

SELECT DISTINCT product_type, sum(price_unit) as price
from inventory_data
group by product_type
having price> 150
order by sum(price_unit);

#5.Find list of transactions having product from produce where
#unit price is more than that of avg unit price of produce

with cte as
(select transactions.transaction_id,price_unit,avg(price_unit) over (order by product_type) as avg_price
from  inventory_data as inventory join transaction_data as transactions 
on inventory.product_id=transactions.product_id 
where product_type='produce')

select transaction_id from cte where price_unit>avg_price








