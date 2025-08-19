const pool = require('./DBConnection');

async function getRecipes() {
    const [rows] = await pool.query('SELECT * FROM recipes');
    return rows;
}
module.exports = getRecipes;