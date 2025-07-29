/*
 Grabs all food and it's methods of preparation, 
 if one of the ingredients are located in food storage.
 Then filters for food located within the freezer using a pattern match.
*/
SELECT DISTINCT
original.FName,
original.Preparation
FROM ingredients original 
JOIN ingredients other 
JOIN location ON original.FName = location.FName
WHERE original.Ingredient_ID != other.Ingredient_ID
AND location.Food_Storage LIKE '%Freezer%';

-- Should I swap the joins? maybe do location onto one of the aliased tables for 
-- better performance? Think about it