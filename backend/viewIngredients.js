const pool = require('./DBConnection');

async function getIngredients() {
    const [rows] = await pool.query('SELECT * FROM Location');
    return rows;
}
module.exports = getIngredients;

