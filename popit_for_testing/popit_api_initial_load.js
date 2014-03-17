var fixtures = require('mongodb-fixtures');

var Db = require('mongodb').Db,
  Connection = require('mongodb').Connection,
  Server = require('mongodb').Server;

var db = new Db('testing-popit-api', new Server("localhost", Connection.DEFAULT_PORT, {}));

fixtures.load();
fixtures.save(db, function() {
  db.close();
  console.dir(fixtures);
});
