-- Create the bookstore database
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

-- Create country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO country (name) VALUES 
('Kenya'), ('Uganda'), ('Tanzania'), ('Rwanda'), ('Ethiopia');

-- Create address_status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

INSERT INTO address_status (status_name) VALUES 
('Current'), ('Old');

-- Create address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100),
    postal_code VARCHAR(10),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

INSERT INTO address (street, city, postal_code, country_id) VALUES
('Moi Avenue', 'Nairobi', '00100', 1),
('Tom Mboya St', 'Kisumu', '40100', 1),
('Kenyatta Road', 'Eldoret', '30100', 1),
('Moi Road', 'Nakuru', '20100', 1),
('Market St', 'Mombasa', '80100', 1);

-- Create customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customer (first_name, last_name, email) VALUES
('Kevin', 'Otieno', 'kevo@mail.com'),
('Mary', 'Wanjiku', 'maryw@mail.com'),
('James', 'Kimani', 'jkimani@mail.com'),
('Joy', 'Walukaya', 'joywalukaya@mail.com'),
('Emmanuel', 'Wandera', 'ewandera@mail.com');

-- Create customer_address table
CREATE TABLE customer_address (
    cust_addr_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 1), (4, 4, 1), (5, 5, 1);

-- Create publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255)
);

INSERT INTO publisher (name, address) VALUES
('Kenya Lit Publishers', 'Nairobi'),
('East African Educational', 'Kampala'),
('Moran Publishers', 'Eldoret'),
('Longhorn Publishers', 'Nairobi'),
('Storymoja Africa', 'Mombasa');

-- Create book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO book_language (name) VALUES 
('English'), ('Kiswahili'), ('French'), ('Luo'), ('Kikuyu');

-- Create author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO author (name) VALUES
('Ngugi wa Thiong"o"'),
('Grace Ogot'),
('Binyavanga Wainaina'),
('Margaret Ogola'),
('Meja Mwangi');

-- Create book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    language_id INT,
    publisher_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

INSERT INTO book (title, language_id, publisher_id, price) VALUES
('The River and The Source', 1, 4, 950.00),
('Weep Not Child', 1, 1, 850.00),
('Coming to Birth', 1, 2, 790.00),
('Going Down River Road', 2, 3, 720.00),
('A Grain of Wheat', 1, 1, 880.00);

-- Create book_author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

INSERT INTO book_author (book_id, author_id) VALUES
(1, 4), (2, 1), (3, 2), (4, 5), (5, 1);

-- Create shipping_method table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

INSERT INTO shipping_method (method_name) VALUES
('Bike Courier'), ('Matatu Dropoff'), ('Pick-up Point'), ('Postal Mail'), ('Same Day Delivery');

-- Create order_status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO order_status (status_name) VALUES
('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');

-- Create cust_order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id) VALUES
(1, '2024-04-01', 1, 2), (2, '2024-04-02', 3, 1), (3, '2024-04-03', 2, 3), (4, '2024-04-04', 4, 4), (5, '2024-04-05', 5, 5);

-- Create order_line table
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 2), (2, 2, 1), (3, 3, 3), (4, 4, 1), (5, 5, 2);

-- Create order_history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATE,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO order_history (order_id, status_id, change_date) VALUES
(1, 1, '2024-03-31'), (1, 2, '2024-04-01'),
(2, 1, '2024-04-01'),
(3, 2, '2024-04-02'), (3, 3, '2024-04-03');

-- Create roles and users for access control
CREATE ROLE admin_role;
CREATE ROLE sales_role;
CREATE ROLE viewer_role;

GRANT ALL PRIVILEGES ON bookstore_db.* TO admin_role;
GRANT SELECT, INSERT, UPDATE ON bookstore_db.cust_order TO sales_role;
GRANT SELECT ON bookstore_db.* TO viewer_role;

CREATE USER 'joy'@'%' IDENTIFIED BY 'joypass';
CREATE USER 'emmanuel'@'%' IDENTIFIED BY 'emmanuelpass';
CREATE USER 'james'@'%' IDENTIFIED BY 'jamespass';

GRANT admin_role TO 'joy'@'%';
GRANT sales_role TO 'emmanuel'@'%';
GRANT viewer_role TO 'james'@'%';

-- Set default roles
SET DEFAULT ROLE admin_role TO 'joy'@'%';
SET DEFAULT ROLE sales_role TO 'emmanuel'@'%';
SET DEFAULT ROLE viewer_role TO 'james'@'%';
