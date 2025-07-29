/*
 * Create a table that stores the recipies.
 */
CREATE TABLE Recipes (
R_ID INT NOT NULL AUTO_INCREMENT,
RName VARCHAR(50) NOT NULL,
Servings INT NOT NULL,
Calories INT NOT NULL,
PRIMARY KEY (R_ID)
);

/*
 * Sample data for the table.
 * Assume Calories is calories per serving. 
 */
INSERT INTO Recipes (RName, Servings, Calories) VALUES
('Spaghetti Bolognese', 4, 500),
('Chicken Caesar Salad', 2, 400),
('Beef Tacos', 3, 300),
('Vegetable Stir Fry', 2, 250),
('Grilled Salmon', 2, 240),
('Cheese Omelette', 1, 300),
('Mushroom Risotto', 4, 420),
('BBQ Chicken Pizza', 6, 400),
('Lentil Soup', 3, 300),
('Pancakes with Syrup', 2, 500);
