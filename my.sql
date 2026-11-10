create table if not exists customers
(

    id uuid primary key default gen_random_uuid(),
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    email varchar(50) not null,
    address jsonb not null,
    phone varchar(50),
    created_at timestamp not null default current_timestamp

    );

insert into customers(firstName,lastName,email,address,phone)
values
    ('Solly','Segogoba','sollyse@gmail.com','{"street number": "magana","code":"7474"}', '0994949');

select * from customers;

create table if not exists products
(
    id uuid primary key default gen_random_uuid(),
    product_name varchar(50) not null,
    description text,
    price decimal(10, 2) not null check (price >= 0),
    stock_quantity int not null default 0 check( stock_quantity >= 0),
    created_at timestamp not null default current_timestamp

    );
insert into products(product_name,description,price,stock_quantity)
values
    ('mango','large mango',10.2,25);

select * from products;



create table if not exists orders (
                                      id uuid primary key default gen_random_uuid(),
    customer_id uuid not null,
    order_date timestamp not null default current_timestamp,
    status varchar(20) not null default 'PENDING',
    constraint fk_orders_customer
    foreign key (customer_id)
    references customers(id),
    constraint chk_order_status
    check (status in ('PENDING','PAID','SHIPPED','CANCELLED'))
    );




CREATE TABLE IF NOT EXISTS order_items
(
    order_item_id uuid primary key default gen_random_uuid(),
    order_id uuid not null,
    product_id uuid not null,
    quantity int not null check(quantity > 0),
    unit_price decimal(10,2) not null check( unit_price >= 0),
    constraint fk_order_items_order
    foreign key (order_id)
    references orders(id),

    constraint fk_order_items_product
    foreign key (product_id)
    references products(id),

    constraint uq_order_product
    unique (order_id, product_id)
    );
























