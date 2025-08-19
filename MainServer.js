const express = require('express');
const pool = require('./backend/DBConnection');
const app = express();
const port = process.env.PORT || 3000;

const getRecipes = require("./backend/viewRecipes");
const getIngredients = require("./backend/viewIngredients");

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

//starts server on local port 3000
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});