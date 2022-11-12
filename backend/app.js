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
    throw err;
  }

  console.log('Connected to the MySQL server.');
});

app.use(express.json()); //parses incoming json requests

app.use(cors({
  origin: ['http://localhost','http://localhost:8080'] //enable cross-platform-source
}));

app.get('/automodells', (req, res) => {
  const sqlQuery =  'Select * from Automodell;';

    database.query(sqlQuery, (err, result) => {
        if (err){
          console.log("Error: " + err);
          res.status(500);
        }else{
          res.status(200);
          let types = []; //pre sort cars by type
          let typeObj = [];
          result.forEach(car => { //look which types exist in the database
              if(types.indexOf(car.Typ)=== -1){ 
                 types.push(car.Typ); //only add types which are not already in the array
              }
          });
          for(let i=0; i < types.length; i++){
            typeObj.push({type:types[i], values:[]}); //make  each type an object
          }
          result.forEach(car =>{

            for(let i =0 ; i < types.length; i++){
                if(car.Typ === types[i]){
                  typeObj[i].values.push(JSON.parse(JSON.stringify(car)));
                }
            }
            
          })
          res.send(JSON.stringify(typeObj));
        }
    });
});

app.get('/automodell/:id', (req, res) => {
  let id =  req.params.id;
  const sqlQuery =  `Select * from Automodell where AutomodellNr = ${id}`;

    database.query(sqlQuery, (err, result) => {
        if (err){
          console.log("Error: " + err);
          res.status(500);
        }else{
          res.status(200);
          res.json(result[0]);
        }
    });
});

app.get('/image/:path', (req, res) => {
  let path =  req.params.path;
  res.sendFile('/assets/' + path, { root: __dirname }, function (err) {
    if (err) {
      res.status(500).send("Oh uh, something went wrong on tha server. " + err);
    }
});
});

app.post('/login/', (req, res) => {
  let user =  req.body;
  let email = user.email;
  let password = user.password;
  const sqlQuery =  `Select * from Kunde where EMail = "${email}" and Password = "${password}"`;

    database.query(sqlQuery, (err, result) => {
        if (err){
          console.log("Error: " + err);
          res.status(500).send("Oh uh, something went wrong on tha server.");
        }else{
          let user = result[0];
          if (user == undefined){
            res.status(401).send("E-Mail or Password wrong.");
          }else{
            res.status(200).send("Login correct.");
          }
        }
    });
});

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`)
});