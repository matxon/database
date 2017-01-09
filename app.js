var express = require('express');
var bodyParser = require('body-parser');
var router = express.Router();

// Осы жерде express модулін орындап app айнымалыға теңейміз
var app = express();

app.use(express.static('public'));
app.use('/', router);

// 
app.get('/a', function( req, res ) {
   res.send('Hello, World!!!');
});

router.get('/', function( req, res ) {
  res.append('Link', ['<http://localhost/>', '<http://localhost:3000/>']);
  res.send('router.get("/", function( req, res ) {}');
});

app.listen(3000, function() {
    console.log('App listening on port 3000');
});
