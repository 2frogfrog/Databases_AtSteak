-- Gets ingredients from recipes where the serving size is 1 or 2
SELECT DISTINCT
FName
FROM ingredients
WHERE ingredients.Ingredient_ID IN (
SELECT ingredients.Ingredient_ID
FROM recipeingredients 
JOIN recipes ON recipeingredients.R_ID = recipes.R_ID
WHERE recipes.Servings = 1

UNION

SELECT ingredients.Ingredient_ID
FROM recipeingredients
JOIN recipes ON recipeingredients.R_ID = recipes.R_ID
Where recipes.Servings = 2
);