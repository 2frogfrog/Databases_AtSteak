/*
Inserting sample data into each table.
*/
/* Sample data curtousy of chatgpt*/
-- Food table sample data.
-- Complete Food table sample data.
INSERT INTO Food (FName, expr_date, price) VALUES
('Apple',           '2025-08-10', 0.99),
('Carrot',          '2025-08-15', 0.45),
('Chicken',         '2025-08-09', 5.25),
('Croissant',       '2025-07-31', 2.00),
('Orange Juice',    '2025-08-12', 2.75),
('Granola Bar',     '2025-09-01', 1.25),
('Ice Cream',       '2025-10-30', 4.49),
('Ketchup',         '2026-02-15', 1.99),
('Black Beans',     '2026-06-01', 0.89),
('Onion',           '2025-08-15', 0.45),
('Tomato Sauce',    '2025-08-20', 1.50),
('Garlic',          '2025-09-01', 0.99),
('Chicken Breast',  '2025-08-12', 5.25),
('Ginger',          '2025-08-18', 0.75),
('Vegetable Broth', '2025-08-25', 2.25),
('Cheddar Cheese',  '2025-09-10', 3.50),
('Egg',             '2025-08-08', 1.20),
('Milk',            '2025-08-09', 2.00),
('Spinach',         '2025-08-13', 1.10),
('Rice',            '2025-08-30', 0.60),
('Beans',           '2026-01-15', 0.89),
('Yogurt',          '2025-08-03', 1.25),
('Oats',            '2026-03-01', 1.10),
('Fish',            '2025-08-05', 4.50),
('Cheese',          '2025-08-10', 3.40),
('Lentils',         '2026-04-15', 1.30),
('Arborio Rice',    '2025-09-01', 1.50),
('Parmesan Cheese', '2025-08-20', 4.00),
('Bell Pepper',     '2025-08-15', 0.70),
('Mushrooms',       '2025-08-10', 1.25),
('Salmon Fillet',   '2025-08-10', 6.00),
('Olive Oil',       '2026-03-01', 3.00),
('BBQ Sauce',       '2025-08-25', 2.25),
('Butter',          '2025-08-15', 1.50),
('Pizza Dough',     '2025-07-30', 2.50),
('Celery',          '2025-08-15', 0.65),
('Pancake Mix',     '2026-01-10', 2.00),
('Maple Syrup',     '2026-02-15', 3.50),
('Pasta',           '2026-02-10', 1.45)
ON DUPLICATE KEY UPDATE
    FName = VALUES(FName),
    expr_date = VALUES(expr_date),
    price = VALUES(price);

/*
 * Sample data for the table.
 * Assume Calories is calories per serving. 
 * The order matters here, it needs to match the insertion order of recipe ingredients
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
('Cheese Omelette',            		2, 280)
ON DUPLICATE KEY UPDATE
    RName = VALUES(RName),
    Servings = VALUES(Servings),
    Calories = VALUES(Calories);

-- Ingrediant table sample data.
INSERT INTO Ingredients (Amount, Preparation, FName) VALUES
(100.00, 'chopped',           'Onion'),
(150.00, 'pureed',            'Tomato Sauce'),
(200.00, 'cubed',             'Chicken Breast'),
(500.00, 'heated',            'Vegetable Broth'),

(2.00,   'minced',            'Garlic'),
(75.00,  'chopped',           'Spinach'),
(100.00, 'sliced',            'Mushrooms'),
(100.00, 'shredded',          'Cheddar Cheese'),
(3.00,   'beaten',            'Egg'),
(150.00, 'warmed',            'Milk'),

(10.00,  'grated',            'Ginger'),
(200.00, 'cooked',            'Pasta'),
(50.00,  'grated',            'Parmesan Cheese'),
(150.00, 'uncooked',          'Arborio Rice'),

(75.00,  'sliced',            'Bell Pepper'),
(250.00, 'stretched',         'Pizza Dough'),
(100.00, 'spread',            'BBQ Sauce'),

(75.00,  'sliced',            'Carrot'),
(75.00,  'chopped',           'Celery'),
(150.00, 'rinsed',            'Lentils'),

(50.00,  'melted',            'Butter'),
(200.00, 'mixed',             'Pancake Mix'),
(100.00, 'drizzled',          'Maple Syrup'),

(30.00,  'heated',            'Olive Oil'),
(180.00, 'grilled',           'Salmon Fillet'),
(20.00,  'brushed',           'Olive Oil'),

(1.00,   'minced',            'Garlic'),
(2.00,   'beaten',            'Egg')
ON DUPLICATE KEY UPDATE
    Amount = VALUES(Amount),
    Preparation = VALUES(Preparation),
    FName = VALUES(FName);

-- Recipe Ingrediant sample data.
INSERT INTO RecipeIngredients (R_ID, Ingredient_ID) VALUES
-- 1. Chicken Soup
(1, 1),   -- Onion  
(1, 2),   -- Tomato Sauce  
(1, 3),   -- Chicken Breast  
(1, 4),   -- Vegetable Broth  
(1, 5),   -- Garlic  
(1, 18),  -- Carrot  
(1, 19),  -- Celery  

-- 2. Spinach Mushroom Frittata
(2, 5),   -- Garlic  
(2, 6),   -- Spinach  
(2, 7),   -- Mushrooms  
(2, 8),   -- Cheddar Cheese  
(2, 9),   -- Egg  
(2, 10),  -- Milk  

-- 3. Creamy Ginger Pasta
(3, 1),   -- Onion  
(3, 11),  -- Ginger  
(3, 10),  -- Milk  
(3, 12),  -- Pasta  
(3, 21),  -- Butter  

-- 4. Mushroom Risotto
(4, 1),   -- Onion  
(4, 7),   -- Mushrooms  
(4, 13),  -- Parmesan Cheese  
(4, 14),  -- Arborio Rice  
(4, 4),   -- Vegetable Broth  

-- 5. BBQ Chicken Pizza
(5, 3),   -- Chicken Breast  
(5, 15),  -- Bell Pepper  
(5, 16),  -- Pizza Dough  
(5, 17),  -- BBQ Sauce  
(5, 8),   -- Cheddar Cheese  

-- 6. Lentil Soup
(6, 1),   -- Onion  
(6, 18),  -- Carrot  
(6, 19),  -- Celery  
(6, 20),  -- Lentils  
(6, 4),   -- Vegetable Broth  

-- 7. Pancakes with Syrup
(7, 9),   -- Egg  
(7, 10),  -- Milk  
(7, 21),  -- Butter  
(7, 22),  -- Pancake Mix  
(7, 23),  -- Maple Syrup  

-- 8. Vegetable Stir Fry
(8, 5),   -- Garlic  
(8, 15),  -- Bell Pepper  
(8, 18),  -- Carrot  
(8, 24),  -- Olive Oil  

-- 9. Grilled Salmon
(9, 5),   -- Garlic  
(9, 25),  -- Salmon Fillet  
(9, 26),  -- Olive Oil  

-- 10. Cheese Omelette
(10, 5),  -- Garlic  
(10, 8),  -- Cheddar Cheese  
(10, 9),  -- Egg  
(10, 21) -- Butter  
ON DUPLICATE KEY UPDATE
    Ingredient_ID = VALUES(Ingredient_ID),
    R_ID = VALUES(R_ID);
    
    
-- Food location sample data.
INSERT INTO Location (Food_Storage, FName, Quantity, Entry_Date)
VALUES
('Fridge',       'Milk',            3000, '2025-08-14'),
('Fridge',       'Egg',             24,   '2025-08-13'),
('Fridge',       'Butter',          500,  '2025-08-12'),
('Fridge',       'Cheddar Cheese',  1000, '2025-08-11'),
('Fridge',       'Parmesan Cheese', 600,  '2025-08-10'),
('Fridge',       'Spinach',         250,  '2025-08-14'),
('Fridge',       'Bell Pepper',     300,  '2025-08-13'),
('Fridge',       'Mushrooms',       400,  '2025-08-13'),
('Fridge',       'Salmon Fillet',   1500, '2025-08-12'),
('Freezer',      'Chicken Breast',  2000, '2025-08-10'),
('Freezer',      'Pizza Dough',     5,    '2025-08-09'),
('Freezer',      'Ice Cream',       3,    '2025-08-01'),
('Pantry',       'Tomato Sauce',    4,    '2025-08-08'),
('Pantry',       'Vegetable Broth', 6,    '2025-08-07'),
('Pantry',       'Olive Oil',       2,    '2025-08-05'),
('Pantry',       'BBQ Sauce',       3,    '2025-08-06'),
('Pantry',       'Maple Syrup',     2,    '2025-08-04'),
('Pantry',       'Garlic',          100,  '2025-08-10'),
('Pantry',       'Ginger',          80,   '2025-08-10'),
('Pantry',       'Onion',           500,  '2025-08-11'),
('Pantry',       'Carrot',          600,  '2025-08-11'),
('Pantry',       'Celery',          400,  '2025-08-11'),
('Dry Storage',  'Lentils',         2000, '2025-08-03'),
('Dry Storage',  'Arborio Rice',    1500, '2025-08-03'),
('Dry Storage',  'Pasta',           1800, '2025-08-03'),
('Dry Storage',  'Pancake Mix',     3,    '2025-08-02'),
('Dry Storage',  'Oats',            1000, '2025-08-02'),
('Dry Storage',  'Rice',            2500, '2025-08-02'),
('Shelf',        'Granola Bar',     12,   '2025-08-01'),
('Shelf',        'Yogurt',          6,    '2025-08-14'),
('Bakery Case',  'Croissant',       10,   '2025-08-14'),
('Cooler',       'Orange Juice',    2000, '2025-08-13'),
('Pantry',       'Ketchup',         2,    '2025-08-05'),
('Pantry',       'Black Beans',     4,    '2025-08-06'),
('Pantry',       'Beans',           3,    '2025-08-06'),
('Pantry',       'Apple',           8,    '2025-08-14'),
('Pantry',       'Fish',            2,    '2025-08-12'),
('Pantry',       'Cheese',          500,  '2025-08-10');

-- Food type sample data.
INSERT INTO FoodType (FName, Category, Unit) VALUES
('Apple',            'Fruit',      'g'),   -- avg ~150g
('Carrot',           'Vegetable',  'g'),
('Chicken',          'Meat',       'g'),
('Croissant',        'Bakery',     'g'),   -- avg ~60g
('Orange Juice',     'Beverage',   'ml'),
('Granola Bar',      'Snack',      'g'),   -- avg ~40g
('Ice Cream',        'Frozen',     'ml'),
('Ketchup',          'Condiment',  'ml'),
('Black Beans',      'Canned',     'g'),
('Onion',            'Vegetable',  'g'),
('Tomato Sauce',     'Condiment',  'ml'),
('Garlic',           'Spice',      'g'),
('Chicken Breast',   'Meat',       'g'),
('Ginger',           'Spice',      'g'),
('Vegetable Broth',  'Broth',      'ml'),
('Cheddar Cheese',   'Dairy',      'g'),
('Egg',              'Dairy',      'g'),   -- avg ~50g per egg
('Milk',             'Dairy',      'ml'),
('Spinach',          'Vegetable',  'g'),
('Rice',             'Grain',      'g'),
('Beans',            'Canned',     'g'),
('Yogurt',           'Dairy',      'ml'),
('Oats',             'Grain',      'g'),
('Fish',             'Meat',       'g'),
('Cheese',           'Dairy',      'g'),
('Lentils',          'Legume',     'g'),
('Arborio Rice',     'Grain',      'g'),
('Parmesan Cheese',  'Dairy',      'g'),
('Bell Pepper',      'Vegetable',  'g'),
('Mushrooms',        'Vegetable',  'g'),
('Salmon Fillet',    'Meat',       'g'),
('Olive Oil',        'Condiment',  'ml'),
('BBQ Sauce',        'Condiment',  'ml'),
('Butter',           'Dairy',      'g'),
('Pizza Dough',      'Bakery',     'g'),
('Celery',           'Vegetable',  'g'),
('Pancake Mix',      'Grain',      'g'),
('Maple Syrup',      'Condiment',  'ml'),
('Pasta',            'Grain',      'g')
ON DUPLICATE KEY UPDATE
    FName = VALUES(FName),
    Category = VALUES(Category),
    Unit = VALUES(Unit);
