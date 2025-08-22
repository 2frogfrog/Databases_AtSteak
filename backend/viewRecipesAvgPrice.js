const pool = require('./DBConnection');

async function viewRecipeAveragePrice() {

    const [rows] = await pool.query('SELECT\n' +
        'recipes.RName,\n' +
        'avg(food.price) AS AVG_Cost_Per_Recipe\n' +
        'FROM recipes JOIN recipeingredients ON recipes.R_ID = recipeingredients.R_ID\n' +
        'JOIN ingredients ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID\n' +
        'JOIN food ON ingredients.FName = food.FName\n' +
        'GROUP BY recipes.RName;');
    return rows;
}
module.exports = viewRecipeAveragePrice;