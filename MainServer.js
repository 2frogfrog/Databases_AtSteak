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

//starts server on local port 3000
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});