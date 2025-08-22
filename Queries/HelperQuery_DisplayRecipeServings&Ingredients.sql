/*
* Shows all of the recipe ingredients and the servings for each recipe.
*/
select 
recipes.servings,
recipes.RName,
ingredients.FName
FROM recipes 
JOIN recipeingredients USING (R_ID)
JOIN ingredients USING (Ingredient_ID);

