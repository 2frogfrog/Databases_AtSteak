const pool = require('./DBConnection');

async function viewSmallServingRecipes() {

    const [rows] = await pool.query('SELECT DISTINCT\n' +
    'FName FROM ingredients\n' +
    'WHERE ingredients.Ingredient_ID IN (\n' +
        'SELECT recipeingredients.Ingredient_ID\n' +
    'FROM recipeingredients\n' +
    'JOIN recipes ON recipeingredients.R_ID = recipes.R_ID\n' +
    'WHERE recipes.Servings = 1\n' +
    'UNION\n' +
    'SELECT recipeingredients.Ingredient_ID\n' +
    'FROM recipeingredients\n' +
    'JOIN recipes ON recipeingredients.R_ID = recipes.R_ID\n' +
    'Where recipes.Servings = 2);');
    return rows;
}
module.exports = viewSmallServingRecipes;