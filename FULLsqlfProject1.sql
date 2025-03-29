create database book_store;
use book_store ;

create table books (Book_ID INT primary key,
Title varchar (100),
Author varchar (100),
Genre varchar (50),
Published_Year INT,
Price numeric(10, 2),
Stock INT
 );
 
 
 create table customers(Customer_ID serial primary key,
 Name varchar (100),
 Email varchar (100),
 Phone varchar (15),
 City varchar (50),
 Country varchar (150)
 );
 
 
 create table orders (Order_ID int primary key,
 Customer_ID INT references customers(Customer_ID),
 Book_ID INT references books(Book_ID),
 Order_Date DATE,
 Quantity INT,
 Total_Amount numeric(10, 2)
 );
 
select * from books;
select * from customers;
select * from orders;


-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where Genre = "Fiction";


-- 2) find books published after the year 1950:
select * from books
where Published_Year > 1950; 


-- 3) list alll customers from the canada:
select * from customers
where Country = 'canada' ;


-- 4) show orders placed in November 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30' ; 


-- 5) Retrieve the total stock of books available:
select sum(Stock) as total_stocks from books; 



-- 6) find the details of the most expensuive book:
select Title, Price from books
where price = ( select MAX(Price) from books);
-- or 
select * from books ORDER BY Price DESC limit 1;



-- 7) show all customers who ordered more than 1 quantity of a book :
SELECT * FROM orders
where Quantity > 1;

-- 8) Retrieve all ordrs where the total amount exceeds $20:
SELECT * FROM orders
where Total_Amount > 20;


-- 9) List all genres available in the books table:
SELECT distinct Genre  FROM books;


-- 10) Find the books with the lowest stoks:
select * from books ORDER BY stock limit 1 ;


-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) from orders;


-- 12) Retrieve the total number of books sold for each genre:
select b.Genre, sum(o.Quantity)
from Orders as o
JOIN books as b
ON o.book_id = b.book_id
group by b.Genre;


-- 13) List customers who have placed at least 2 orders:
select Customer_ID, COUNT(Order_ID) as order_count
from orders 
group by Customer_ID
having count(Order_ID) >=2;

-- with name

select o.Customer_ID, c.name, COUNT(o.Order_ID) as order_count
from orders as o
JOIN customers as c
ON o.Customer_ID = c.Customer_ID
group by o.Customer_ID, c.name
having count(o.Order_ID) >=2;



-- 14) Find the most frequently order book:
select Book_ID, COUNT(order_id) as order_count
from orders
group by Book_ID 
order by order_count DESC LIMIT 1; 


-- 15)  Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) as Total_books
from books as b
join orders as o
on b.Book_ID = o.Book_ID
group by b.author;    


-- 16) List the cities where customers who spent over $30 are located: 
 select distinct c.city
 from orders as o
 join customers as c on o.customer_id = c.customer_id
 where o.total_amount > 30;
 
 
 -- 17) Find the customer who spent the most on orders:
 select c.customer_id, c.name, sum(o.total_amount) as total_spent
 from customers as c
 join orders as o
 on c.customer_id = o.customer_id 
 group by c.customer_id
 order by total_spent desc limit 1;
 
 
 
 -- 18) calculate the stock remaining after fulfilling all orders:
 select b.book_id, b.title, b.stock, COALESCE (SUM(o.quantity), 0) as Order_quantity, 
 b.stock - COALESCE (SUM(o.quantity), 0) as Rmaining_Quantity
 from books as b
 LEFT JOIN orders as o
 on b.Book_ID = o.Book_ID
 group by b.Book_ID
 order by b.book_id;

 




