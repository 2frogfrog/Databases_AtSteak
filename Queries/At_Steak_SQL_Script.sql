

-- ************************************ --
--               Part A                 --
-- There are 10 tables for our database --
-- ************************************ --

/*
Database creation statement
*/
CREATE DATABASE IF NOT EXISTS AT_STEAK;
USE AT_STEAK;

/*
Creating a table that holds information about different foods and their attributes.
*/
CREATE TABLE IF NOT EXISTS Food (
    F_ID INT AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL CHECK (length(category) > 0),
    FName VARCHAR(50) NOT NULL UNIQUE CHECK (length(FName) > 0),
    expr_date DATE NOT NULL, --  replaced with actual date
    price DECIMAL(6,2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY(F_ID)
)ENGINE = InnoDB;


/*
Creating a table that stores the location and amount of a food item.
*/
CREATE TABLE IF NOT EXISTS Location (
Location_ID INT NOT NULL AUTO_INCREMENT,
Food_Storage VARCHAR(50) NOT NULL CHECK (length(Food_Storage) > 0),
FName varchar(50) NOT NULL,
Quantity INT NOT NULL CHECK (Quantity > 0 ),
Entry_Date DATE NOT NULL,
PRIMARY KEY (Location_ID),
FOREIGN KEY (FName) REFERENCES Food (FName)
ON DELETE CASCADE
ON UPDATE CASCADE
)ENGINE = InnoDB;


/*
Creating a table that holds foods to be used in recipes.
*/
CREATE TABLE IF NOT EXISTS Ingredients (
    Ingredient_ID INT NOT NULL AUTO_INCREMENT,
    Amount DECIMAL(6,2) NOT NULL CHECK (Amount >= 0),       -- e.g., 200.00 (grams, ml, etc.)
    Unit VARCHAR(10),                   -- Optional: Unit of the amount
    Preparation VARCHAR(50) NOT NULL,           -- e.g., chopped, minced, peeled
    FName VARCHAR(50) NOT NULL,        -- Name of the food item (e.g., Onion, Garlic)
    CONSTRAINT uniquePrepAmount UNIQUE (FName, Amount, Preparation),
    PRIMARY KEY (Ingredient_ID),
    FOREIGN KEY (FName) REFERENCES Food (FName)
    ON DELETE CASCADE
)ENGINE = InnoDB;




/*
 * Create a table that stores the recipes.
 */
CREATE TABLE IF NOT EXISTS Recipes (
R_ID INT NOT NULL AUTO_INCREMENT,
RName VARCHAR(50) UNIQUE NOT NULL CHECK (length(RName) > 0),
Servings INT NOT NULL CHECK (Servings > 0),
Calories INT NOT NULL CHECK (Calories >= 0),
PRIMARY KEY (R_ID)
)ENGINE = InnoDB;


/*
 * Create a table that stores the recipe ingredients
 */
CREATE TABLE IF NOT EXISTS RecipeIngredients (
	-- Recipe ID
    R_ID INT NOT NULL CHECK (R_ID >= 0),
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
    ON DELETE CASCADE -- If an ingredient is removed we need to remove it from the recipe ingredients.
    -- We might want to reconsider cascading here but it would need to be discussed.
    ON UPDATE CASCADE
)ENGINE = InnoDB;


-- ************************************ --
--               Part B                 --
-- The sample of the data of each table --
-- ************************************ --
-- Food table sample data.
INSERT INTO Food (category, FName, expr_date, price) VALUES
('Fruit',       'Apple',          '2025-08-10', 0.99),
('Vegetable',   'Carrot',         '2025-08-15', 0.45),
('Meat',        'Chicken',        '2025-08-09', 5.25),
('Bakery',      'Croissant',      '2025-07-31', 2.00),
('Beverage',    'Orange Juice',   '2025-08-12', 2.75),
('Snack',       'Granola Bar',    '2025-09-01', 1.25),
('Frozen',      'Ice Cream',      '2025-10-30', 4.49),
('Condiment',   'Ketchup',        '2026-02-15', 1.99),
('Canned',      'Black Beans',    '2026-06-01', 0.89),
('Vegetable',   'Onion',          '2025-08-15', 0.45),
('Condiment',   'Tomato Sauce',   '2025-08-20', 1.50),
('Spice',       'Garlic',         '2025-09-01', 0.99),
('Meat',        'Chicken Breast', '2025-08-12', 5.25),
('Spice',       'Ginger',         '2025-08-18', 0.75),
('Broth',       'Vegetable Broth','2025-08-25', 2.25),
('Dairy',       'Cheddar Cheese', '2025-09-10', 3.50),
('Dairy',       'Egg',            '2025-08-08', 1.20),
('Dairy',       'Milk',           '2025-08-09', 2.00),
('Vegetable',   'Spinach',        '2025-08-13', 1.10),
('Grain',       'Rice',           '2025-08-30', 0.60),
('Canned',      'Beans',          '2026-01-15', 0.89),
('Dairy',       'Milk',           '2025-08-01', 2.25),
('Grain',       'Pasta',          '2026-02-10', 1.45),
('Dairy',       'Yogurt',         '2025-08-03', 1.25),
('Grain',       'Oats',           '2026-03-01', 1.10),
('Meat',        'Fish',           '2025-08-05', 4.50),
('Dairy',       'Cheese',         '2025-08-10', 3.40),
('Legume',      'Lentils',        '2026-04-15', 1.30),
('Grain',       'Arborio Rice',   '2025-09-01', 1.50),
('Dairy',       'Parmesan Cheese','2025-08-20', 4.00),
('Vegetable',   'Bell Pepper',    '2025-08-15', 0.70),
('Vegetable',   'Mushrooms',      '2025-08-10', 1.25),
('Meat',        'Salmon Fillet',  '2025-08-10', 6.00),
('Condiment',   'Olive Oil',      '2026-03-01', 3.00),
('Condiment',   'BBQ Sauce',      '2025-08-25', 2.25),
('Dairy',       'Butter',         '2025-08-15', 1.50),
('Bakery',      'Pizza Dough',    '2025-07-30', 2.50),
('Vegetable',   'Celery',         '2025-08-15', 0.65),
('Grain',       'Pancake Mix',    '2026-01-10', 2.00),
('Condiment',   'Maple Syrup',    '2026-02-15', 3.50)
ON DUPLICATE KEY UPDATE
	category = VALUES(category),
    FName = VALUES(FName),
    expr_date = VALUES(expr_date),
    price = VALUES(price);

/*
 * Sample data for the table.
 * Assume Calories is calories per serving. 
 */
INSERT INTO Recipes (RName, Servings, Calories) VALUES 
('Chicken Soup',               		4, 150),
('Spinach and Mushroom Frittata', 	4, 320),
('Creamy Pasta',               		4, 600),
('Mushroom Risotto',           		4, 450),
('BBQ Chicken Pizza',          		6, 300),
('Lentil Soup',                		4, 180),
('Pancakes with Syrup',        		3, 350),
('Vegetable Stir Fry',         		4, 220),
('Grilled Salmon',             		2, 400),
('Cheese Omelette',            		2, 280);


-- Ingrediant table sample data.
INSERT INTO Ingredients (Amount, Unit, Preparation, FName) VALUES
(200.00, 'g',  'chopped',      'Onion'),           -- ID 1
(100.00, 'ml', 'boiled',       'Tomato Sauce'),    -- ID 2
(2.00,   'pcs','sliced',       'Garlic'),          -- ID 3
(1.00,   'tbsp','minced',      'Ginger'),          -- ID 4
(50.00,  'g',  'sliced',       'Carrot'),          -- ID 5

(50.00,  'g',  'chopped',      'Spinach'),         -- ID 6
(150.00, 'g',  'diced',        'Bell Pepper'),     -- ID 7
(100.00, 'g',  'chopped',      'Celery'),          -- ID 8
(200.00, 'g',  'sliced',       'Mushrooms'),       -- ID 9
(300.00, 'g',  'diced',        'Chicken Breast'),  -- ID 10

(250.00, 'g',  'cubed',        'Chicken'),         -- ID 11
(180.00, 'g',  'flaked',       'Salmon Fillet'),   -- ID 12
(180.00, 'g',  'flaked',       'Fish'),            -- ID 13
(100.00, 'g',  'grated',       'Cheddar Cheese'),  -- ID 14
(150.00, 'g',  'shredded',     'Parmesan Cheese'), -- ID 15

(3.00,   'pcs','beaten',       'Egg'),             -- ID 16
(500.00, 'ml', 'poured',       'Milk'),            -- ID 17
(100.00, 'g',  'stirred',      'Yogurt'),          -- ID 18
(100.00, 'g',  'melted',       'Butter'),          -- ID 19
(300.00, 'g',  'steamed',      'Rice'),            -- ID 20

(300.00, 'g',  'steamed',      'Arborio Rice'),    -- ID 21
(120.00, 'g',  'boiled',       'Pasta'),           -- ID 22
(200.00, 'g',  'toasted',      'Oats'),            -- ID 23
(200.00, 'g',  'none',         'Pancake Mix'),     -- ID 24
(300.00, 'g',  'rolled',       'Pizza Dough'),     -- ID 25

(85.00,  'g',  'halved',       'Croissant'),       -- ID 26
(120.00, 'g',  'chopped',      'Apple'),           -- ID 27
(180.00, 'ml', 'chilled',      'Orange Juice'),    -- ID 28
(40.00,  'g',  'unwrapped',    'Granola Bar'),     -- ID 29
(100.00, 'g',  'drained',      'Black Beans'),     -- ID 30

(150.00, 'g',  'rinsed',       'Beans'),           -- ID 31
(150.00, 'g',  'soaked',       'Lentils'),         -- ID 32
(250.00, 'ml', 'none',         'Vegetable Broth'), -- ID 33
(30.00,  'ml', 'dispensed',    'Ketchup'),         -- ID 34
(50.00,  'ml', 'none',         'Olive Oil'),       -- ID 35

(120.00, 'ml', 'poured',       'BBQ Sauce'),       -- ID 36
(50.00,  'ml', 'poured',       'Maple Syrup');     -- ID 37


-- Recipe Ingrediant sample data.
INSERT INTO RecipeIngredients (R_ID, Ingredient_ID) VALUES
-- Chicken Soup (R_ID=1)
(1, 1),   -- Onion
(1, 2),   -- Tomato Sauce
(1, 10),  -- Chicken Breast
(1, 33),  -- Vegetable Broth

-- Spinach and Mushroom Frittata (R_ID=2)
(2, 3),   -- Garlic
(2, 6),   -- Spinach
(2, 9),   -- Mushrooms
(2, 14),  -- Cheddar Cheese
(2, 16),  -- Egg
(2, 17),  -- Milk

-- Creamy Pasta (R_ID=3)
(3, 1),   -- Onion
(3, 4),   -- Ginger
(3, 17),  -- Milk
(3, 22),  -- Pasta

-- Mushroom Risotto (R_ID=4)
(4, 1),   -- Onion
(4, 9),   -- Mushrooms
(4, 15),  -- Parmesan Cheese
(4, 21),  -- Arborio Rice
(4, 33),  -- Vegetable Broth

-- BBQ Chicken Pizza (R_ID=5)
(5, 7),   -- Bell Pepper
(5, 10),  -- Chicken Breast
(5, 25),  -- Pizza Dough
(5, 36),  -- BBQ Sauce

-- Lentil Soup (R_ID=6)
(6, 1),   -- Onion
(6, 5),   -- Carrot
(6, 8),   -- Celery
(6, 32),  -- Lentils
(6, 33),  -- Vegetable Broth

-- Pancakes with Syrup (R_ID=7)
(7, 16),  -- Egg
(7, 17),  -- Milk
(7, 19),  -- Butter
(7, 24),  -- Pancake Mix
(7, 37),  -- Maple Syrup

-- Vegetable Stir Fry (R_ID=8)
(8, 5),   -- Carrot
(8, 7),   -- Bell Pepper
(8, 35),  -- Olive Oil

-- Grilled Salmon (R_ID=9)
(9, 3),   -- Garlic
(9, 12),  -- Salmon Fillet
(9, 35),  -- Olive Oil

-- Cheese Omelette (R_ID=10)
(10, 3),  -- Garlic
(10, 14), -- Cheddar Cheese
(10, 16), -- Egg
(10, 19); -- Butter

-- Food location sample data.
INSERT INTO Location (Food_Storage, FName, Quantity, Entry_Date)
VALUES
('Pantry A', 'Rice', 50, '2025-07-21'),
('Pantry B', 'Beans', 35, '2025-07-22'),
('Fridge A', 'Milk', 10, '2025-07-24'),
('Pantry A', 'Pasta', 20, '2025-07-23'),
('Freezer B', 'Chicken', 60, '2025-07-20'),
('Fridge B', 'Yogurt', 15, '2025-07-25'),
('Pantry C', 'Oats', 40, '2025-07-22'),
('Freezer A', 'Fish', 30, '2025-07-23'),
('Fridge A', 'Cheese', 25, '2025-07-21'),
('Pantry B', 'Lentils', 45, '2025-07-24');

-- ************************************ --
--               Part C                 --
--        Designing SQL Queries         --
-- ************************************ --

-- Query 1: grabs all ingredients from a single recipe. This example is pancakes and syrup
SELECT
    r.RName AS Recipe_Name,
    i.FName AS Ingredient_Name,
    i.Amount,
    i.Unit,
    i.Preparation
FROM Recipes r
         JOIN RecipeIngredients ri ON r.R_ID = ri.R_ID
         JOIN Ingredients i ON ri.Ingredient_ID = i.Ingredient_ID
         JOIN Food f ON i.FName = f.FName
WHERE r.RName = 'Cheese Omelette';

-- Query 2: Counts how many ingredients cost more than the average price out of all food items in each recipe.
-- Lists the recipe name and the number of Expensive Ingredients.
SELECT
    r.RName AS Recipe_Name,
    COUNT(*) AS 'Number of Expensive Ingredients'
FROM Recipes r
         JOIN RecipeIngredients ri ON r.R_ID = ri.R_ID
         JOIN Ingredients i ON ri.Ingredient_ID = i.Ingredient_ID
WHERE
    i.FName IN (
        SELECT FName
        FROM Food
        WHERE price > (SELECT AVG(price) FROM Food)
    )
GROUP BY r.R_ID, r.RName;

-- Query 3: Determines all foods that have been listed as ingredients in a table.
SELECT
    FName,
    price
FROM food AS expensive_food
WHERE EXISTS (
    SELECT expensive_food.FName
    FROM ingredients AS listed_food
    WHERE expensive_food.FName = listed_food.FName)

-- Query 4: Gets the average price of each recipe
SELECT
    recipes.RName,
    avg(food.price) AS AVG_Cost_Per_Recipe
FROM recipes JOIN recipeingredients ON recipes.R_ID = recipeingredients.R_ID
             JOIN ingredients ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID
             JOIN food ON ingredients.FName = food.FName
GROUP BY recipes.RName

-- Query 5: Gets ingredients from recipes where the serving size is 1 or 2
SELECT DISTINCT
    FName
FROM ingredients
WHERE ingredients.Ingredient_ID IN (
    SELECT ingredients.Ingredient_ID
    FROM recipeingredients
             JOIN recipes ON recipeingredients.R_ID = recipes.R_ID
    WHERE recipes.Servings = 1

    UNION

    SELECT ingredients.Ingredient_ID
    FROM recipeingredients
             JOIN recipes ON recipeingredients.R_ID = recipes.R_ID
    Where recipes.Servings = 2
);

-- Query 6: grabs recipes and their ingredient names and required amount as well as the quantity you have available
SELECT
    recipes.RName AS Recipe_Name,
    ingredients.FName AS Ingredient_Name,
    ingredients.Amount AS Required_Amount,
    ingredients.Unit AS Unit,
    COALESCE(SUM(location.Quantity), 0) AS Available_Quantity
FROM Recipes
         JOIN RecipeIngredients recipeingredients
              ON recipes.R_ID = recipeingredients.R_ID
         JOIN Ingredients
              ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID
         JOIN Food
              ON ingredients.FName = food.FName
         LEFT JOIN Location
                   ON food.FName = location.FName
GROUP BY recipes.RName, ingredients.FName, ingredients.Amount, ingredients.Unit
ORDER BY recipes.RName, ingredients.FName;

-- Query 7: Gives the recipes you can have all the ingredients for
SELECT Recipes.RName
FROM Recipes
         JOIN RecipeIngredients ON Recipes.R_ID = RecipeIngredients.R_ID
         JOIN Ingredients ON RecipeIngredients.Ingredient_ID = Ingredients.Ingredient_ID
         LEFT JOIN Location ON Ingredients.FName = Location.FName
GROUP BY Recipes.RName
HAVING COUNT(Ingredients.Ingredient_ID) = COUNT(Location.FName);

-- Query 8: Gives the amounts needed for ingredients and how much you are short
SELECT
    Recipes.RName,
    Ingredients.FName,
    Ingredients.Amount AS Required_Amount,
    COALESCE(SUM(Location.Quantity), 0) AS In_Stock,
    Ingredients.Amount - COALESCE(SUM(Location.Quantity), 0) AS Shortage
FROM Recipes
         JOIN RecipeIngredients ON Recipes.R_ID = RecipeIngredients.R_ID
         JOIN Ingredients ON RecipeIngredients.Ingredient_ID = Ingredients.Ingredient_ID
         LEFT JOIN Location ON Ingredients.FName = Location.FName
GROUP BY Recipes.RName, Ingredients.FName, Ingredients.Amount
HAVING Shortage > 0
ORDER BY Recipes.RName, Ingredients.FName;

-- Query 9: Grab the recipes for ingredients that are going to expire within three days of the current date.
SELECT
    recipes.RName,
    food.FName,
    ingredients.Amount,
    ingredients.Unit,
    ingredients.Preparation
FROM recipes
         JOIN recipeingredients ON recipes.R_ID = recipeingredients.R_ID
         JOIN ingredients ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID
         JOIN food ON ingredients.FName = food.FName
WHERE food.expr_date BETWEEN CURRENT_DATE AND date_add(CURRENT_DATE, INTERVAL 3 DAY)
ORDER BY recipes.RName;

-- Query 10: Grabs all food and it's methods of preparation,
--  if one of the ingredients are located in food storage.
--  Then filters for food located within the freezer using a pattern match.
SELECT DISTINCT
    original.FName,
    original.Preparation
FROM ingredients original
         JOIN ingredients other
         JOIN location ON original.FName = location.FName
WHERE original.Ingredient_ID != other.Ingredient_ID
AND location.Food_Storage LIKE '%Freezer%';
