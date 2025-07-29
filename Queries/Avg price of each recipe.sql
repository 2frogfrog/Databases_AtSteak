-- Average price of each recipe
SELECT
recipes.RName,
avg(food.price) AS AVG_Cost_Per_Recipe
FROM recipes JOIN recipeingredients ON recipes.R_ID = recipeingredients.R_ID
JOIN ingredients ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID
JOIN food ON ingredients.FName = food.FName
GROUP BY recipes.RName
