const pool = require('./DBConnection');

async function viewSmallServingRecipes() {

    const [rows] = await pool.query('SELECT DISTINCT RName\n' +
    'FROM recipes r\n' +
    'WHERE r.Servings IN (1, 2);');
    return rows;
}
module.exports = viewSmallServingRecipes;