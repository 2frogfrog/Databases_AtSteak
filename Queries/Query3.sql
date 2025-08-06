/* 
Determines all foods that have been listed as ingredients in a table.
*/
SELECT
FName, 
price 
FROM food AS expensive_food 
WHERE EXISTS ( 
SELECT expensive_food.FName 
FROM ingredients AS listed_food 
WHERE expensive_food.FName = listed_food.FName )
