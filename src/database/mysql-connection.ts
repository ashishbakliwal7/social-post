import mysql from "mysql";

const connection = mysql.createConnection({
  host: "34.93.16.194",
  user: "root",
  password: "",
  database: "social_network",
});

connection.connect(function (err: any) {
  if (err) throw err;
});

module.exports = connection;
