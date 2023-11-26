const util = require('../utils/util.js')

let AWS = require("aws-sdk");
require("dotenv").config();

let secretAccessKey = process.env.DYNAMO_DB_SECRET_ACCESS_KEY
let accessKeyId = process.env.DYNAMO_DB_ACCESS_KEY_ID
let env = process.env.NODE_ENV;

AWS.config.update({
    credentials: {
        secretAccessKey: secretAccessKey,
        accessKeyId: accessKeyId,
    },
    region: "us-east-1",
    maxRetries: 1,
});

var connection = new AWS.DynamoDB.DocumentClient();

module.exports = connection;