-- This script is already implemented into the initialization script

CREATE TABLE customers
(
  customer_id INT GENERATED ALWAYS AS IDENTITY,
  email varchar(254) NOT NULL,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  gender varchar(15) NOT NULL,
  address text,
  birth_date date NOT NULL,
  cell varchar(250),
  PRIMARY KEY (customer_id)
  );

CREATE TABLE items
(
  item_id INT GENERATED ALWAYS AS IDENTITY,
  seller_id INT,
  name varchar(100) NOT NULL,
  price_per_unit numeric NOT NULL,
  description text,
  active boolean NOT NULL,
  PRIMARY KEY (item_id),
  FOREIGN KEY(seller_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders
(
  order_id INT GENERATED ALWAYS AS IDENTITY,
  buyer_id INT NOT NULL,
  item_id INT NOT NULL,
  date_ordered date NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY(buyer_id) REFERENCES customers(customer_id),
  FOREIGN KEY(item_id) REFERENCES items(item_id)
);


CREATE TABLE categories
(
  category_name varchar(100) NOT NULL,
  PRIMARY KEY (category_name)
);

CREATE TABLE categoryitem
(
  category_name varchar(100) NOT NULL,
  item_id INT NOT NULL,
  FOREIGN KEY(category_name) REFERENCES categories(category_name),
  FOREIGN KEY(item_id) REFERENCES items(item_id)
);

CREATE TABLE itemregister
(
  item_id INT NOT NULL,
  seller_id INT NOT NULL,
  name varchar(100) NOT NULL,
  price_per_unit numeric NOT NULL,
  description text,
  active boolean NOT NULL,
  at_date date NOT NULL,
  PRIMARY KEY (item_id),
  FOREIGN KEY(seller_id) REFERENCES customers(customer_id)
);

