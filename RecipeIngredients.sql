
CREATE TABLE RecipeIngredients (
	-- Recipe ID
    R_ID INT NOT NULL,
    -- Ingredient ID
    Ingredient_ID INT NOT NULL,
    -- Optional: How much of the ingredient is used
    -- Quantity DECIMAL(6,2) NOT NULL,
    -- Optional: Unit of measure
    -- Unit VARCHAR(10),
    PRIMARY KEY (R_ID, Ingredient_ID),
    -- for connecting later
    -- FOREIGN KEY (R_ID) REFERENCES Recipes(R_ID),
    FOREIGN KEY (Ingredient_ID) REFERENCES Ingredients(Ingredient_ID)
);

-- example:
INSERT INTO RecipeIngredients (R_ID, Ingredient_ID) VALUES
-- Recipe 101: Chicken Soup
(101, 1),	-- Onion
(101, 4),	-- Chicken Breast
(101, 6),	-- Vegetable Broth
(101, 2),	-- Tomato Sauce

-- Recipe 102: Omelette
(102, 3),	-- Garlic
(102, 8),	-- Egg
(102, 7),	-- Cheddar Cheese
(102, 10),	-- Spinach

-- Recipe 103: Creamy Pasta
(103, 9),	-- Milk
(103, 1),	-- Onion
(103, 5);	-- Ginger

/*
all their ID and Name
| Ingredient_ID | FName           |
| ------------- | --------------- |
| 1             | Onion           |
| 2         	| Tomato Sauce    |
| 3             | Garlic          |
| 4             | Chicken Breast  |
| 5             | Ginger          |
| 6             | Vegetable Broth |
| 7             | Cheddar Cheese  |
| 8             | Egg             |
| 9             | Milk            |
| 10            | Spinach         |
*/

/*
we might add all the optional later as it can create a more correct recipe 
*/