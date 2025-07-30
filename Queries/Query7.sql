--Gives the recipes you can have all the ingredients for
SELECT Recipes.RName
FROM Recipes
         JOIN RecipeIngredients ON Recipes.R_ID = RecipeIngredients.R_ID
         JOIN Ingredients ON RecipeIngredients.Ingredient_ID = Ingredients.Ingredient_ID
         LEFT JOIN Location ON Ingredients.FName = Location.FName
GROUP BY Recipes.RName
HAVING COUNT(Ingredients.Ingredient_ID) = COUNT(Location.FName);