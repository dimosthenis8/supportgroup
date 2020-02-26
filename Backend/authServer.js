require('dotenv').config();

const bcrypt = require('bcrypt');
const saltRounds = 10;
let aPassword = 'thispass';
let hash = '$2b$10$dg5YQ7Bg.oW2sYqazn/kZeDm5kVHJP7P7XDn0w9LtJBglh8.Xnt4e';

const jwt = require('jsonwebtoken');
const express = require('express');
const app = express();
app.use(express.json());

var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root123",
  database: "data"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

/*
app.get('/test', authenticateToken, (req, res) => {
    res.json(req.user)
})
*/

app.delete('/logout', (req, res) => {
    const refreshToken = req.body.token;
    if (refreshToken == null) return res.sendStatus(401)

    let sql='DELETE FROM tokens WHERE refreshTokens='.concat("'", refreshToken, "'");
    console.log(sql);
    con.query(sql, (err, result) => {
        if(err) throw err;
        else {
            console.log('logout successful. Bye bye!');
            res.sendStatus(204);
        }
    })

})


//this function refreshes the Access Token after Time Out:
app.post('/token', (req, res) => {
    //will configure the following line to take refresh Token from http0cookie
    const refreshToken = req.body.token
    //refresh token not sent:
    if (refreshToken == null) return res.sendStatus(401)

    let sql='SELECT * FROM tokens WHERE refreshTokens='.concat("'", refreshToken, "'");
    console.log(sql);
    con.query(sql, (err, result) => {
        if(err) throw err;
        //if refresh Token is not found:
        if (result==''){
        	console.log('refresh Token is incorrect');
        	res.status(403).send('refresh Token is incorrect'); 
        }
        //if refresh Token is found in the database:
        else{
            jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
                if (err) return res.sendStatus(403)
                const accessToken = generateAccessToken(user)
                res.json({ accessToken: accessToken })
              })
        }
    })   
})

//This function creates the tokens and sends them to the user:
app.post('/login', authorize, (req, res) => {
    //if client credentials are valid
    //generate the tokens and send them to the client
    if(!req.user) {
        return res.status(401).send('username or password incorrect');
    }
    const accessToken = generateAccessToken(req.user);
    const refreshToken = generateRefreshToken(req.user);
    //!
    //should add the tokens to the database here?
    //!
    res.json({ accessToken: accessToken, refreshToken: refreshToken })
})

//this function checks if user credentials are correct
async function authorize(req, res, next) {
   //check for basic auth header
    if(!req.headers.authorization || req.headers.authorization.indexOf('Basic') === -1) {
        return res.status(401).json({message: 'Missing Authorization Header' });
    }

    //extract auth credentials
    const base64Credentials = req.headers.authorization.split(' ')[1];
    const credentials = Buffer.from(base64Credentials, 'base64').toString('ascii');
    const [username, password] = credentials.split(':');

    //find user in database
    let sql='SELECT * FROM users WHERE username='.concat("'", username, "'");
    console.log(sql);
    con.query(sql, (err, result) => {
        if(err) throw err;
        if (result==''){
        	console.log('username or password incorrect');
        	res.status(401).send('username or password incorrect'); 
        }
        else{
            //check if password is correct
            bcrypt.compare(password, result[0]['hashpass'], function(err, res) {
                if(err) throw err;
                if(!res) {
                    console.log('password incorrect');
                    req.user = null;
                    next();
                }
                else {
                    console.log('Verified!')
                    //forwarding user info without the hasspass
                    const { hashpass, ...userWithoutHashpass } = result[0];
                    req.user = userWithoutHashpass;
                    next();
                }
            }) 
        }
    })
}

//this function authenticates the accessToken provided by the user:
function authenticateToken (req, res, next) {
    //const authHeader = req.headers['X-OBSERVATORY AUTH']
    const authHeader = req.headers.authorization
    const token = authHeader && authHeader.split(' ')[1]
    if (!token) return res.status(401).send('missing access token')

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.sendStatus(403).send('access token is no longer valid')
        req.user = user
        next()
    })
}

function generateAccessToken(user) {
    return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });
}

function generateRefreshToken(user) {
    const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
    
    //store the refresh token in the database: 
    let sql = 'INSERT INTO tokens (refreshTokens) VALUES ('.concat("'", refreshToken, "');");
    console.log(sql);
    con.query(sql, (err, result) => {
        if(err) throw err;
    })

    return refreshToken;
}

app.listen(3000);


/*
The flow of information should be as follows:

1. Client sends credentials to the server
2. Server verifies the credentials, generates a JWT and sends it back as a response
3. Subsequent requests from the client have a JWT in the request headers
4. Server validates the token and if valid, provide the requested response.
*/
