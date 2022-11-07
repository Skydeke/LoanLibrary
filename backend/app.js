const express = require('express');
const mysql = require('mysql');

require("dotenv").config(); //load environment variables

const app = express();
const PORT = 8081;

let database = mysql.createConnection({
  host:  process.env.DB_HOST,
  user:  process.env.DB_USER,
  password:  process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

database.connect(function(err) {
  if (err) {
    return console.error('error: ' + err.message);
  }

  console.log('Connected to the MySQL server.');
});


app.get('/', (req, res) => {
  const sqlQuery =  'CREATE TABLE Auto (Bezeichnung VARCHAR(50));';

    database.query(sqlQuery, (err) => {
        if (err) throw err;

    res.send('Table created!');
    });
});

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`)
});