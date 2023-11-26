const util = require('../utils/util.js');
require("dotenv").config();

var env = process.env.NODE_ENV;
var tableName = process.env.TABLE_NAME || "safe_walk_dev"
let type

switch (util.removeSpace(env)) {
    case 'development':
        type = 'development'
        tableName = 'safe_walk_dev'
        break;
    case 'production':
        type = 'production'
        tableName = tableName
        break;
    default:
        break;
}

var ServerConfigData = {
    type,
    tableName,
}

module.exports = ServerConfigData;