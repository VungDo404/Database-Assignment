const mysql = require('mysql2');

// Create a connection pool
const pool = mysql.createPool({
  host: 'localhost',          // Replace with your host
  user: 'root',               // Replace with your username
  password: 'root',   // Replace with your password
  database: 'root',   // Replace with your database
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  port: 3307,
  multipleStatements: true,
});

// Use promise-based API
const db = pool.promise();

module.exports = db;