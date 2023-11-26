const LoggerMiddleware = require("../Middlewares/LoggerMiddleware.js");
var dbController = require("../Controllers/DatabaseController.js");

module.exports = function (app) {
  app.get("/database_commit", LoggerMiddleware, dbController.commitDatabase);
};
