DROP USER IF EXISTS 'ecommerceapp'@'localhost';
CREATE USER 'ecommerceapp'@'localhost' IDENTIFIED BY 'ecommerceapp';
GRANT ALL PRIVILEGES ON *.* TO 'ecommerceapp'@'localhost';
FLUSH PRIVILEGES;
