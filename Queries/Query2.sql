/*
  Counts how many ingredients cost more than the average price out of all food items in each recipe.
  Lists the recipe name, and the number of Expensive Ingredients.
*/
SELECT 
r.RName AS Recipe_Name,
COUNT(*) AS 'Number of Expensive Ingredients'
FROM Recipes r
JOIN RecipeIngredients ri ON r.R_ID = ri.R_ID
JOIN Ingredients i ON ri.Ingredient_ID = i.Ingredient_ID
WHERE 
    i.FName IN (
        SELECT FName 
        FROM Food 
        WHERE price > (SELECT AVG(price) FROM Food)
    )
GROUP BY r.R_ID, r.RName;
