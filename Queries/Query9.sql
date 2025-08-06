-- Grab the recipes for ingredients that are going to expire within three days of the current date.
-- Current date as of writing is 2025/07/26 in YYYY/MM/DD format
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




