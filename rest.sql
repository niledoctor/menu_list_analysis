create database Restaurant_orders;
#Retrieve all columns from the menu_items table.
select* 
from menu_items;
#display the first 5 rows from the order_details table.
select*
from order_details
limit 5;
# Select the item_name and price columns for items in the 'American' category.
select item_name, price
from menu_items
where category = 'American';
#Sort the result by price in descending order
select item_name, price
from menu_items
where category = 'American'
order by price desc;
#Calculate the average price of menu items.
select avg(price)
from menu_items;
#Find the total number of orders placed.
select count(order_id)
from order_details;
#Retrieve the item_name, order_date, and order_time for all items
#in the order_details table, including their respective menu item details.
SELECT *
FROM menu_items
INNER JOIN order_details ON menu_items.ï»¿menu_item_id = order_details.item_id;
#List the menu items (item_name) with a price greater than the average price of all menu items.
select item_name, price
from menu_items
where price > (select avg(price) 
from menu_items);
#Extract the month from the order_date and count the number of orders placed in each month.
SELECT MONTH(order_date) AS month, COUNT(*) AS num_orders
FROM order_details
GROUP BY MONTH(order_date);

#Show the categories with the average price greater than $15.
#Include the count of items in each category.
SELECT menu_items.category,
       AVG(menu_items.price) AS avg_price,
       COUNT(ï»¿menu_item_id) AS item_count
FROM menu_items
GROUP BY menu_items.category
HAVING avg_price > 15;

#Display the item_name and price, and indicate if the item is priced above $20 with a new column named 'Expensive'.
SELECT item_name,
       price,
       CASE
           WHEN price > 20 THEN 'Yes'
           ELSE 'No'
       END AS Expensive
FROM menu_items;

#Update the price of the menu item with item_id = 101 to $25.
UPDATE menu_items
SET price = 25
WHERE ï»¿menu_item_id = 101;

#Insert a new record into the menu_items table for a dessert item.
INSERT INTO menu_items (item_name, category, price)
VALUES ('Om Ali', 'Dessert', 10.99);

#Delete all records from the order_details table where the order_id is less than 100.
DELETE FROM order_details
WHERE order_id < 100;

#Rank menu items based on their prices, displaying the item_name and its rank.
SELECT 
    item_name,
    price,
    @rank := @rank + 1 AS r
FROM 
    (SELECT 
        item_name,
        price
    FROM 
        menu_items
    ORDER BY 
        price DESC) AS ranked_items,
    (SELECT @rank := 0) AS r;

#Display the item_name and the price difference from the previous and next menu item.
SELECT 
    item_name,
    price,
    price - LAG(price) OVER (ORDER BY price) AS price_diff_previous,
    LEAD(price) OVER (ORDER BY price) - price AS price_diff_next
FROM 
    menu_items;
