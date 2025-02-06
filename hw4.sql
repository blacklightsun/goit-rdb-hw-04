-- task 1
-- --------------------------
create schema if not exists LibraryManagement;
use LibraryManagement;

create table if not exists authors (
	author_id int auto_increment primary key,
	author_name varchar(50)
);

create table if not exists genres (
	genre_id int auto_increment primary key,
	genre_name varchar(50)
);

create table if not exists books (
	book_id int auto_increment primary key,
	title varchar(100),
	publication_year year,
	author_id int,
	genre_id int,
foreign key (author_id) references authors(author_id),
foreign key (genre_id) references genres(genre_id)
);

create table if not exists users (
	user_id int auto_increment primary key,
	username varchar(50),
	email varchar(100)
);

create table if not exists borrowed_books (
	borrow_id int auto_increment primary key,
	book_id int,
	user_id int,
	borrow_date date,
	return_date date,
foreign key (book_id) references books(book_id),
foreign key (user_id) references users(user_id)
);

-- task 2
-- --------------------------
insert into authors (author_name) values ('Dikkens'), ('Trump'), ('Shevchenko');
insert into genres (genre_name) values ('poems'), ('novel'), ('biography');
insert into books (title, publication_year, author_id, genre_id) values ('The Adventures of Oliver Twist', 2002, 1, 2), ('Kobzar', 1991, 3, 1), ('Madman', 2025, 2, 3);
insert into users (username, email) values ('Poroshenko', 'poro@ukr.net'), ('Zelya', 'zelya@ukr.net'), ('Romanenko', 'roma@ukr.net');
insert into borrowed_books (book_id, user_id, borrow_date, return_date) values (1, 3, '2025-01-01', '2025-01-28'), (2, 1, '2025-01-02', '2025-01-29');


-- task 3
-- --------------------------
use mydb;

select 
    order_details.id as order_details_id, 
    order_details.order_id as order_details_order_id, 
    order_details.product_id as order_details_product_id, 
    order_details.quantity as order_details_quantity,
    grand_products.*,
    grand_orders.*
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id;


-- task 4.1
-- --------------------------
select 
    count(order_details.id) as order_details_id_count
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id;

-- task 4.2
-- --------------------------
-- змінюємо inner на left та right
select 
    count(order_details.id) as order_details_id_count
from order_details
right join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
left join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id;
/*Висновок: 
Після зміни inner на left/right у операторі join кількість рядків не змінилася, тому що:
1. Дані в базі консистентні - немає записів з даними, до яких відсутні первинні ключі в таблицях-довідниках, 
та/або відсутні записи в таблицях-довідниках, які не використовуються (не задіяні) в інших таблицях (з даними).
2. Кількість рядків у результуючому запиті залежить від кількості рядків у таблиці order_details. 
Я лише додавав інформацію зі зв'язаних таблиць. 
Тобто збільшувалася тільки кількість атрибутів (колонок), а кількість рядків залишалася такою ж як і в таблиці order_details. 
Щоб довести це - нижче запит на кількість рядків у order_details, який покажу туж саму кількість рядків = 518.
*/
select 
    count(order_details.id) as order_details_id_count
from order_details;

-- task 4.3
-- --------------------------
select 
    count(order_details.id) as order_details_id_count
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id
where employees_employee_id > 3 and employees_employee_id <= 10;

-- task 4.4
-- --------------------------
select 
	categories_name,
    count(product_id) as row_qty,
    avg(quantity) as avg_order_details_quantity
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id
where employees_employee_id > 3 and employees_employee_id <= 10
group by categories_name;

-- task 4.5
-- --------------------------
select 
	categories_name,
    count(product_id) as row_qty,
    avg(quantity) as avg_order_details_quantity
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id
where employees_employee_id > 3 and employees_employee_id <= 10
group by categories_name
having avg_order_details_quantity > 21;

-- task 4.6
-- --------------------------
select 
	categories_name,
    count(product_id) as row_qty,
    avg(quantity) as avg_order_details_quantity
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id
where employees_employee_id > 3 and employees_employee_id <= 10
group by categories_name
having avg_order_details_quantity > 21
order by row_qty desc;

-- task 4.7
-- --------------------------
select 
	categories_name,
    count(product_id) as row_qty,
    avg(quantity) as avg_order_details_quantity
from order_details
inner join (
	select 
		products.id as products_id, 
		products.name as products_name, 
		products.supplier_id as products_supplier_id, 
		products.category_id as products_category_id, 
		products.unit as products_unit, 
		products.price as products_price,
		suppliers.id as suppliers_id, 
		suppliers.name as suppliers_name, 
		suppliers.contact as suppliers_contact, 
		suppliers.address as suppliers_address, 
		suppliers.city as suppliers_city, 
		suppliers.postal_code as suppliers_postal_code, 
		suppliers.country as suppliers_country, 
		suppliers.phone as suppliers_phone,
		categories.id as categories_id, 
		categories.name as categories_name, 
		categories.description as categories_description
	from products
	inner join suppliers on products.supplier_id = suppliers.id
	inner join categories on products.category_id = categories.id
) as grand_products on order_details.product_id = grand_products.products_id
inner join (
	select 
		customers.id as customers_id, 
		customers.name as customers_name, 
		customers.contact as customers_contact, 
		customers.address as customers_address, 
		customers.city as customers_city, 
		customers.postal_code as customers_postal_code, 
		customers.country as customers_country,
		employees.employee_id as employees_employee_id, 
		employees.last_name as employees_last_name, 
		employees.first_name as employees_first_name, 
		employees.birthdate as employees_birthdate, 
		employees.photo as employees_photo, 
		employees.notes as employees_notes,
		shippers.id as shippers_id, 
		shippers.name as shippers_name, 
		shippers.phone as shippers_phone,
		orders.id as orders_id, 
		orders.customer_id as orders_customer_id, 
		orders.employee_id as orders_employee_id, 
		orders.date as orders_date, 
		orders.shipper_id as orders_shipper_id
	from orders
	inner join customers on orders.customer_id = customers.id
	inner join employees on orders.employee_id = employees.employee_id
	inner join shippers on orders.shipper_id = shippers.id
) as grand_orders on order_details.order_id = grand_orders.orders_id
where employees_employee_id > 3 and employees_employee_id <= 10
group by categories_name
having avg_order_details_quantity > 21
order by row_qty desc
limit 4
offset 1;


