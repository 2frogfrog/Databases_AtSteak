
CREATE TABLE Ingredients (
    Ingredient_ID INT NOT NULL AUTO_INCREMENT,
    Amount DECIMAL(6,2) NOT NULL,       -- e.g., 200.00 (grams, ml, etc.)
    Unit VARCHAR(10),                   -- Optional: Unit of the amount
    Preparation VARCHAR(50),           -- e.g., chopped, minced, peeled
    FName VARCHAR(50) NOT NULL,        -- Name of the food item (e.g., Onion, Garlic)
    PRIMARY KEY (Ingredient_ID)
);

-- example:
INSERT INTO Ingredients (Amount, Unit, Preparation, FName) VALUES
(200.00, 'g', 'chopped', 'Onion'),
(100.00, 'ml', 'boiled', 'Tomato Sauce'),
(2.00, 'pcs', 'sliced', 'Garlic'),
(300.00, 'g', 'diced', 'Chicken Breast'),
(1.00, 'tbsp', 'minced', 'Ginger'),
(250.00, 'ml', 'none', 'Vegetable Broth'),
(100.00, 'g', 'grated', 'Cheddar Cheese'),
(3.00, 'pcs', 'beaten', 'Egg'),
(500.00, 'ml', 'none', 'Milk'),
(50.00, 'g', 'chopped', 'Spinach');

/*
we might add some optional type to the table later as it can create a more correct recipe 
*/