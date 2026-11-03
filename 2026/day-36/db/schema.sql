CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO products (name, price)
VALUES
('Face Wash', 299.00),
('Moisturizer', 499.00),
('Sunscreen', 599.00);