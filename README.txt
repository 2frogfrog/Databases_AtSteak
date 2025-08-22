@Steak


What it is:

This is a CRUD web application designed to manage a persons food storage. It contains functionality to determine recipes that a person can cook with the ingredients they have in storage. It connects a MYSQL database to an express server to deliver information to a web page. 


What it uses:

JavaScript - Handles backend logic

HTML - Displays information from the backend to a web environment

Bootswatch - HTML themes 

Node.js - Runtime environment

Express.js - Back end web application framework(facilitates requests)

MYSQL DBMS - Sets up the database and holds user information


How to run it:

As of writing(8/21/2025) this has only been confirmed to work with MYSQL.

1) Launch a MYSQL Server.
2) Run the @Steak_BuildScript in MYSQL located in the directory /DBSetup.
3) Run the Data_Insertion_Script located in the directory /DBSetup.
4) Open the project in your favorite editor/IDE
5) Fill in the information required to connect to the MYSQL server in DBConnection.js, located in /backend.
6) Run the script MainServer located in the projects root.
7) Open the HTML viewRecipes/viewIngredients

Note - these pages are configured to run on localhost:3000 specifically and you may need to modify your run configurations to ensure that the html pages are loaded at that address.
