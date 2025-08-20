const pool = require('./DBConnection');

async function getIngredients() {
    const [rows] = await pool.query('SELECT * FROM Location');
    return rows;
}
module.exports = getIngredients;

/*
recipes.forEach(function(recipe) { //this function ideally should fetch a list of recipes from the database but its just theory rn
    tableBody.append(`
      <tr>
        <td>${recipe.RName}</td>
        <td>
          <button class="btn btn-sm btn-info view-btn" data-city='${JSON.stringify(recipe)}'>View</button>
          <button class="btn btn-sm btn-warning edit-btn" data-city='${JSON.stringify(recipe)}'>Edit</button>
          <button class="btn btn-sm btn-danger delete-btn" data-city="${recipe.RName}">Delete</button>
        </td>
      </tr>
    `);
  });
 */
