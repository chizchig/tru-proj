const express = require('express');
const app = express();
const bodyParser = require('body-parser');

// middleware for parsing request body
app.use(bodyParser.urlencoded({ extended: true }));

// serve index page on root path
app.get('/', function(req, res) {
  res.sendFile(__dirname + '/index.html');
});

// serve login page on "/page2" path
app.get('/page2', function(req, res) {
  res.sendFile(__dirname + '/log_in.html');
});

app.get('/register', function(req, res) {
    res.sendFile(__dirname + '/register.html');
  });
  

// serve congratulations page on "/page2/congratulations" path
app.get('/page2/congratulations', function(req, res) {
  res.sendFile(__dirname + '/congratulations.html');
});

// handle registration form submission
app.post('/register', function(req, res) {
  const username = req.body.username;
  const password = req.body.password;
  const firstname = req.body.firstname;
  const lastname = req.body.lastname;

  // perform validation checks here
  // if everything is valid, create the new user and redirect to the login page

  res.redirect('/page2');
});

// handle login form submission
app.post('/login', function(req, res) {
  const username = req.body.username;
  const password = req.body.password;

  // perform authentication checks here
  // if login successful, redirect to the congratulatory page
  // otherwise, redirect back to the login page with an error message

  res.redirect('/page2/congratulations');
});

// handle logout button click
app.post('/logout', function(req, res) {
  // perform logout functionality here
  // redirect to the login page after successful logout
  res.redirect('/page2');
});

// start server on port 3000
app.listen(3000, function() {
  console.log('Server running on port 3000; http://localhost:3000');
});
