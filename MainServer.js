const express = require('express');
const pool = require('./backend/DBConnection');
const app = express();
const port = process.env.PORT || 3000;

const getRecipes = require("./backend/viewRecipes");

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

//Search query
app.post('/api/recipes/search', async (req, res) => {
    const { query } = req.body;
    const [rows] = await pool.query(
        'SELECT * FROM recipes WHERE RName LIKE ?', [`%${query}%`]
    );
    res.json(rows);
});

//starts server on local port 3000
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});