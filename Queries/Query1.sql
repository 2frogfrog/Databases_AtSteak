/*
 Grabs all ingredients from a single recipe. That recipe being Pancakes with Syrup
*/

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