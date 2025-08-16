
-- grabs recipes and their ingredient names and required amount as well as the quantity you have available
SELECT
    recipes.RName AS Recipe_Name,
    ingredients.FName AS Ingredient_Name,
    ingredients.Amount AS Required_Amount,
    foodtype.Unit AS Unit,
    COALESCE(SUM(location.Quantity), 0) AS Available_Quantity
FROM Recipes
         JOIN RecipeIngredients recipeingredients
              ON recipes.R_ID = recipeingredients.R_ID
         JOIN Ingredients
              ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID
         JOIN Food
              ON ingredients.FName = food.FName
         JOIN foodtype
			  ON ingredients.FName = foodtype.FName
         LEFT JOIN Location
                   ON food.FName = location.FName
GROUP BY recipes.RName, ingredients.FName, ingredients.Amount, foodtype.Unit
ORDER BY recipes.RName, ingredients.FName;

