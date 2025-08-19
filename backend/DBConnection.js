const mysql = require('mysql2/promise');
//console.log("Hopefully this works")

const pool = mysql.createPool({
    host: "localhost",
    user: "",
    password: "",
    database: "",
    connectionLimit: 10,
    port: '3306',
});

module.exports = pool;
