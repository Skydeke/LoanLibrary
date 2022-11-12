const express = require('express');
const mysql = require('mysql');
const cors = require('cors');


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

app.use(express.json()); //parses incoming json requests

app.use(cors({
  origin: 'http://localhost' //enable cross-platform-source
}));

app.get('/', (req, res) => {
  const sqlQuery =  'CREATE TABLE Auto (Bezeichnung VARCHAR(50));';

    database.query(sqlQuery, (err) => {
        if (err) throw err;

    res.send('Table created!');
    });
});

app.get('/assets/car.jpg', (req, res) => { //Images for testing purpose
  res.sendFile('/assets/car.jpg',{ root: __dirname });
});

app.get('/assets/car2.jpg', (req, res) => {
  res.sendFile('/assets/car2.jpg',{ root: __dirname });
});

app.post('/car', (req, res) => {
  console.log(req.body);
  res.status(200)
  res.json({'msg':'success'});
});

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`)
});