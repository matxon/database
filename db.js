// 1. Қажетті пакеттерді қосу
var mysql = require('mysql');
var express = require('express');
var router = express.Router();
// Бұл пакеттің не үшін қажет екенін әлі біле алмай тұрмын
//var bodyParser = require('body-parser');


var app = express();

app.use(express.static('public'));
app.set('views', './view');
app.set('view engine', 'jade');

app.use('/', router);


var connection = mysql.createConnection({
  host    : 'localhost',
  user    : 'root',
  password: 'DbyljeC3',
  database: 'test'
});

// __________________________________________________________________________
// Алдын ала Базаға қосылып алмаса болмайды
// өйткені функциялар асинхронды болғандықтан базаға жасалған запросымыздың
// жауабы кеш келеді
connection.connect(function(err){
  // Бұл жерде 3 түрлі қате бар
  // 1. Логин, пароль дұрыс емес
  // 2. Көрсетілген база жоқ
  // 3. Mysql серверге қосыла алмай жатыр
  if (err) {
    console.error('Error connecting: ' + err);
    return;
  }
  console.log('connected as id ' + connection.threadId);
});
// --------------------------------------------------------------------------






router.get('/', function(req, res){

  connection.query( 'select * from users;', function( err, rows, fields ) {
    if (err) {
      console.error('Error /: ' + err);
      res.render('error.jade', { error: err });
    } else {
      //console.log(rows);
      res.render('index.jade', { title: rows });
    }
  });

});



router.get('/creat', function(req, res){

      res.render('create_user.jade', { title: '' });
});



router.get('/docs', function(req, res){

  connection.query( 'select * from documents;', function( err, rows ) {
    if (err) {
      console.error('Error /: ' + err);
      res.render('error.jade', { error: err });
    } else {
      //console.log(rows);
      res.render('documents.jade', { title: rows });
    }
  });

});




router.get('/users', function(req, res){

  //connection.query( 'select * from users;', function( err, rows) {
  connection.query( 'select * from documents;', function( err, rows) {
    if (err) {
      console.error('Error /users: ' + err);
      res.json('error.jade');
    } else {
      console.log(rows);
      res.json( rows );
    }
  });

});


app.listen(3000, function() {
  console.log('Listennig on port 3000...');
});