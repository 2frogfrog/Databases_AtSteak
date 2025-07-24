CREATE TABLE Food (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50),
    FName VARCHAR(100),
    expr_date INT, --this is the number of days before expiratiobn
    price DECIMAL(6,2),
    PRIMARY KEY (FName) 
);

/* Sample data curtousy of chatgpt */
INSERT INTO Food (category, FName, expr_date, price) VALUES 
('Fruit', 'Apple', 30, 0.99),
('Fruit', 'Banana', 7, 0.59),
('Vegetable', 'Carrot', 21, 0.49),
('Meat', 'Chicken Breast', 2, 5.99),
('Meat', 'Ground Beef', 1, 6.49),
('Dairy', 'Milk', 7, 3.29),
('Dairy', 'Cheddar Cheese', 30, 4.79),
('Bakery', 'Bread', 5, 2.49),
('Bakery', 'Croissant', 2, 1.99),
('Snack', 'Potato Chips', 90, 2.99),
('Snack', 'Granola Bar', 120, 1.49),
('Seafood', 'Salmon', 2, 9.99),
('Frozen', 'Frozen Pizza', 180, 6.99),
('Beverage', 'Orange Juice', 10, 3.89),
('Beverage', 'Bottled Water', 365, 0.89);