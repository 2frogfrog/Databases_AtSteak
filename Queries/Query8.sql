-- Gives the amounts needed for ingredients and how much you are short
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