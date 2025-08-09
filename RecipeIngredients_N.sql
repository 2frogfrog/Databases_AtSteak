CREATE TABLE IF NOT EXISTS RecipeIngredients (
    R_ID INT NOT NULL,
    Ingredient_ID INT NOT NULL,
    PRIMARY KEY (R_ID, Ingredient_ID),
    FOREIGN KEY (R_ID) REFERENCES Recipes(R_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Ingredient_ID) REFERENCES Ingredients(Ingredient_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB;
