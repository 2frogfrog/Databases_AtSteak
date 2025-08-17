
-- ************************************ --
--               Part A                 --
-- There are 6 tables for our database  --
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
    Amount DECIMAL(6,2) NOT NULL CHECK (Amount >= 0),       -- e.g., 200.00 (grams, ml, etc.)                   -- Optional: Unit of the amount
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

/*
* created table to access category of food and what unit fo measurement it takes
*/
CREATE TABLE IF NOT EXISTS FoodType (
    FName VARCHAR(100) PRIMARY KEY,
    Category VARCHAR(50),
    Unit VARCHAR(50)
)ENGINE = InnoDB;
