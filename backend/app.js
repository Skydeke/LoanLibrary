const express = require('express')
const mysql = require('mysql')
const cors = require('cors')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')

require('dotenv').config() // load environment variables

const app = express()
const PORT = 8081

const database = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
})

database.connect(function (err) {
  if (err) {
    throw err
  }

  console.log('Connected to the MySQL server.')
})

app.use(express.json()) // parses incoming json requests

app.use(
  cors({
    origin: ['http://localhost', 'http://localhost:8080'] // enable cross-platform-source
  })
)

function verifyToken(req, res, next) {
  // middleware function
  const token = req.headers.authorization
  if (token !== undefined) {
    req.token = token
    next()
  } else {
    res.sendStatus(403) // Acces forbidden
  }
}

app.get('/reservations', verifyToken, (req, res) => {
  // usem middleware function
  try {
    // console.log("Token for reservations " + req.token);
    const decoded = jwt.verify(req.token, 'secret') // do something with the token, user is authenticated
    const kundenNr = decoded.KundenNr
    const sqlQuery = `Select *
                          from Reservierung re
                          where re.KundenNr = ${kundenNr} and re.AusleihvorgangNr is null` // Only send Reservations that havent been made good on

    database.query(sqlQuery, (err, result) => {
      if (err) {
        console.log('Error: ' + err)
        res.status(500)
      } else {
        res.status(200)
        res.json(result)
      }
    })
  } catch (err) {
    res.sendStatus(403) // Acces forbidden
  }
})

app.get('/bills', verifyToken, (req, res) => {
  // usem middleware function
  try {
    const decoded = jwt.verify(req.token, 'secret') // do something with the token, user is authenticated
    const kundenNr = decoded.KundenNr
    const sqlQuery = `Select *
                          from Reservierung re, Rechnung r, Ausleihvorgang a
                          where re.KundenNr = ${kundenNr} and re.AusleihvorgangNr = a.AusleihvorgangNr and a.AusleihvorgangNr = r.AusleihvorgangNr`

    database.query(sqlQuery, (err, result) => {
      if (err) {
        console.log('Error: ' + err)
        res.status(500)
      } else {
        res.status(200)
        res.json(result)
      }
    })
  } catch (err) {
    res.sendStatus(403) // Acces forbidden
  }
})

app.delete('/reservation/:id', (req, res) => {
  const ResNr = req.params.id
  const sqlQuery = `DELETE
                      FROM Reservierung
                      WHERE ResNr = ${ResNr}`

  database.query(sqlQuery, (err, result) => {
    if (err) {
      console.log('Error: ' + err)
      res.status(500)
    } else {
      res.status(200)
      res.send(result)
    }
  })
})

app.post('/reservation', (req, res) => {
  const newReservation = req.body
  const startDate = newReservation.geplanterStart
    .toString()
    .replace('T', ' ')
    .replace('Z', '')
  const endDate = newReservation.geplantesEnde
    .toString()
    .replace('T', ' ')
    .replace('Z', '')
  const sqlQuery = `insert into Reservierung (geplanterStart, geplantesEnde, AutomodellNr, KundenNr, AusleihvorgangNr)
                      values ('${startDate}', '${endDate}', '${newReservation.AutomodellNr}', '${newReservation.KundenNr}',
                              ${newReservation.AusleihvorgangNr});`
  database.query(sqlQuery, (err, result) => {
    // get the last KundenNummer
    if (err) {
      console.log(err)
      console.log(result)
      res.status(500).send('Oh uh, something went wrong on tha server.')
    } else {
      res.status(200).send(result)
    }
  })
})

app.get('/automodells', (req, res) => {
  const sqlQuery = 'Select * from Automodell;'

  database.query(sqlQuery, (err, result) => {
    if (err) {
      console.log('Error: ' + err)
      res.status(500)
    } else {
      res.status(200)
      const types = [] // pre sort cars by type
      const typeObj = []
      result.forEach(car => {
        // look which types exist in the database
        if (types.indexOf(car.Typ) === -1) {
          types.push(car.Typ) // only add types which are not already in the array
        }
      })
      for (let i = 0; i < types.length; i++) {
        typeObj.push({ type: types[i], values: [] }) // make  each type an object
      }
      result.forEach(car => {
        for (let i = 0; i < types.length; i++) {
          if (car.Typ === types[i]) {
            typeObj[i].values.push(car)
          }
        }
      })
      res.send(JSON.stringify(typeObj))
    }
  })
})

app.post('/registration', (req, res) => {
  const user = req.body
  const encryptedPassword = bcrypt.hashSync(user.password, 10)
  const sqlQuery = `insert into Kunde (Vorname, ZweiterVorname, Nachname, Ort, PLZ, Land, Strasse, HausNr, EMail,
                                         Password)
                      values ('${user.firstName}', '${user.secondName}', '${user.lastName}', '${user.location}',
                              ${user.plz}, 'Deutschland', '${user.street}', ${user.houseNumber}, '${user.email}',
                              '${encryptedPassword}');`
  database.query(sqlQuery, (err, result) => {
    // get the last KundenNummer
    if (err) {
      res.status(500).send('Oh uh, something went wrong on tha server.')
    } else {
      const token = jwt.sign(
        {
          email: user.email,
          KundenNr: result.insertId,
          Vorname: user.firstName,
          Nachname: user.lastName,
          ZweiterVorname: user.secondName
        },
        'secret',
        { expiresIn: '1h' }
      )
      res.json({ token })
    }
  })
})

app.get('/automodell/:id', (req, res) => {
  const id = req.params.id
  const sqlQuery = `Select *
                      from Automodell
                      where AutomodellNr = ${id}`

  database.query(sqlQuery, (err, result) => {
    if (err) {
      console.log('Error: ' + err)
      res.status(500)
    } else {
      res.status(200)
      res.json(result[0])
    }
  })
})

app.get('/automodell/ausstattungen/:id', (req, res) => {
  const id = req.params.id
  const sqlQuery = `Select aus.Bezeichnung, aus.AusstattungNr
                      from Ausstattung aus,
                           Automodell a,
                           ist_grundausstattung_bei gr
                      where a.AutomodellNr = ${id}
                        and a.AutomodellNr = gr.AutomodellNr
                        and gr.AusstattungNr = aus.AusstattungNr`

  database.query(sqlQuery, (err, result) => {
    if (err) {
      console.log('Error: ' + err)
      res.status(500)
    } else {
      res.status(200)
      res.json(result)
    }
  })
})

app.get('/image/:path', (req, res) => {
  const path = req.params.path
  if (path !== undefined && path !== 'undefined') {
    res.sendFile('/assets/' + path, { root: __dirname }, function (err) {
      if (err) {
        res
          .status(500)
          .send('Oh uh, something went wrong on tha server. ' + err)
      }
    })
  }
})

app.post('/login/', (req, res) => {
  const user = req.body
  const email = user.email
  const password = user.password
  const sqlQuery = `Select *
                      from Kunde
                      where EMail = "${email}"`
  database.query(sqlQuery, (err, result) => {
    if (err) {
      console.log('Error: ' + err)
      res.status(500).send('Oh uh, something went wrong on tha server.')
    } else {
      const user = result[0]
      if (user === undefined) {
        res.status(401).send('E-Mail or Password wrong.')
      } else {
        bcrypt.compare(password, user.Password, function (error, result) {
          if (error) {
            res
              .status(500)
              .send('Oh uh, something went wrong on tha server. ' + err)
          }
          if (result) {
            const token = jwt.sign(
              {
                email,
                KundenNr: user.KundenNr,
                Vorname: user.Vorname,
                Nachname: user.Nachname,
                ZweiterVorname: user.ZweiterVorname
              },
              'secret',
              { expiresIn: '1h' }
            )

            res.json({ token })
          } else {
            res.status(401).send('E-Mail or Password wrong.')
          }
        })
      }
    }
  })
})

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`)
})
