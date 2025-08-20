const express = require('express');
const pool = require('./backend/DBConnection');
const app = express();
const port = process.env.PORT || 3000;

const getRecipes = require("./backend/viewRecipes");
const getIngredients = require("./backend/viewIngredients");
const viewIngredientsGoingBad = require("./backend/viewIngredientsGoingBad");

//Grabs directories
app.use(express.static('frontend'));
app.use(express.json());

//establish a route to get the recipes
app.get('/api/recipes', async (req, res) => {
    try {
        const recipes = await getRecipes();
        res.json(recipes);
    }catch(err) {
        console.error('Error fetching recipes',err);
        res.status(500).json({error: "Database error"});
    }
});

// Search query for recipes
app.post('/api/recipes/search', async (req, res) => {
    const { query } = req.body;
    const [rows] = await pool.query(
        'SELECT * FROM recipes WHERE RName LIKE ?', [`%${query}%`]
    );
    res.json(rows);
});

//establish a route to get the ingredients
app.get('/api/ingredients', async (req, res) => {
    try {
        const ingredients = await getIngredients();
        res.json(ingredients);
    }catch(err) {
        console.error('Error fetching ingredients',err);
        res.status(500).json({error: "Database error"});
    }
});
// Search query for ingredients
app.post('/api/ingredients/search', async (req, res) => {
    const { query } = req.body;
    const [rows] = await pool.query(
        'SELECT * FROM ingredients WHERE FName LIKE ?', [`%${query}%`]
    );
    res.json(rows);
});

app.delete('/api/recipes/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query(
            'DELETE FROM recipes WHERE R_ID = ?', [id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: "Recipe not found" });
        }

        res.json({ message: "Recipe deleted successfully" });
    } catch (err) {
        console.error('Error deleting recipe', err);
        res.status(500).json({ error: "Database error" });
    }
});

app.get('/api/recipes/viewOne/:id', async (req, res) => {
    const id = req.params.id;
    try {
        const [result] = await pool.query('SELECT \n' +
            'ingredients.FName,\n' +
            'location.Food_Storage,\n' +
            'location.quantity,\n' +
            'foodtype.Unit,\n' +
            'DATE_FORMAT(ENTRY_Date, \'%Y-%m-%d\') AS Entry_Date \n' +
            'FROM location\n' +
            'JOIN ingredients using(FName)\n' +
            'JOIN recipeingredients using(Ingredient_ID)\n' +
            'JOIN recipes using(R_ID)\n' +
            'JOIN foodtype using(FName)\n' +
            'WHERE R_ID = ?', [id]);
        if (result.length === 0) {
            return res.status(404).send('Item not found');
        }

        res.json(result); // send JSON instead of rendering a template
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

app.get('/api/recipes/viewRecipesIngredients/:id', async (req, res) => {
    const id = req.params.id;
    try {
        const [result] = await pool.query('SELECT\n' +
            '    Recipes.RName,\n' +
            '    Ingredients.FName,\n' +
            '    Ingredients.Amount AS Required_Amount,\n' +
            '    foodtype.Unit,\n' +
            '    COALESCE(SUM(Location.Quantity), 0) AS In_Stock,\n' +
            '    Ingredients.Amount - COALESCE(SUM(Location.Quantity), 0) AS Shortage\n' +
            'FROM Recipes\n' +
            '         JOIN RecipeIngredients ON Recipes.R_ID = RecipeIngredients.R_ID\n' +
            '         JOIN Ingredients ON RecipeIngredients.Ingredient_ID = Ingredients.Ingredient_ID\n' +
            '         LEFT JOIN Location ON Ingredients.FName = Location.FName\n' +
            '         JOIN foodtype ON Location.FName = foodtype.FName\n' +
            'WHERE recipes.R_ID = ?' +
            'GROUP BY Recipes.RName, Ingredients.FName, Ingredients.Amount\n' +
            'HAVING Shortage > 0\n' +
            'ORDER BY Recipes.RName, Ingredients.FName;', [id]);
        if (result.length === 0) {
            return res.status(404).send('Item not found');
        }

        res.json(result); // send JSON instead of rendering a template
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});


//Query to view ingredients going bad
app.get('/api/ingredientsGoingBad', async (req, res) => {
    try {
        const offIngredients = await viewIngredientsGoingBad();
        res.json(offIngredients);
    }catch(err) {
        console.error('Error fetching ingredients',err);
        res.status(500).json({error: "Database error"});
    }
});
//starts server on local port 3000
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});