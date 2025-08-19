const pool = require('./DBConnection');

async function viewIngredientsGoingBad() {

    const [rows] = await pool.query('SELECT\n' +
        'food.FName,\n' +
        'ingredients.Amount,\n' +
        'foodtype.Unit,\n' +
        'ingredients.Preparation\n' +
        'FROM recipes \n' +
        'JOIN recipeingredients ON recipes.R_ID = recipeingredients.R_ID\n' +
        'JOIN ingredients ON recipeingredients.Ingredient_ID = ingredients.Ingredient_ID\n' +
        'JOIN food ON ingredients.FName = food.FName\n' +
        'JOIN foodtype ON food.FName = foodtype.FName\n' +
        'WHERE food.expr_date BETWEEN CURRENT_DATE AND date_add(CURRENT_DATE, INTERVAL 3 DAY)\n' +
        'ORDER BY recipes.RName;');
    return rows;
}
module.exports = viewIngredientsGoingBad;