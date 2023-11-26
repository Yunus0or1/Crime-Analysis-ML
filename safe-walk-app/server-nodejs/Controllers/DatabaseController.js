var express = require("express");
var app = express();
const { ServerEnum } = require("../configs/EnumData.js");
const docClient = require("../configs/dbConfig.js");
const util = require("../utils/util.js");
const ServerConfigData = require("../configs/ServerConfigData.js");
var env = process.env.NODE_ENV;

async function commitDatabase(req, res) {
  await scanAndDelete();
  return util.sendSuccessResponse(res);
}

async function scanAndDelete() {
  const params = {
    TableName: ServerConfigData.tableName,
  };

  const scanResults = [];
  let items;

  try {
    do {
      items = await docClient.scan(params).promise();
      items.Items.forEach((item) => scanResults.push(item));
      params.ExclusiveStartKey = items.LastEvaluatedKey;
    } while (typeof items.LastEvaluatedKey !== "undefined");

    for (let data of scanResults) {
      var currentItem = {
        TableName: ServerConfigData.tableName,
        Key: {
          id: data.id
        },
      };

      items = await docClient.delete(currentItem).promise();
    }
  } catch (err) {
    console.log(err);
    return false;
  }

  return true;
}

module.exports = {
  commitDatabase,
};
