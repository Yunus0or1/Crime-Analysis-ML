const { ServerEnum, AccessPattern } = require("../configs/EnumData.js");
const util = require("../utils/util.js");
const docClient = require("../configs/dbConfig.js");
const dotenv = require("dotenv").config({ path: ".env" });
const ServerConfigData = require("../configs/ServerConfigData.js");
const EnumData = require("../configs/EnumData.js");
var env = process.env.NODE_ENV;
var envCheckData = process.env.ENV_CHECK_DATA

async function getAppData(request, response) {
  try {
    let appVersion = 1
    let questionVersion = 1
    let updateMust = true
    let questionList1 = []
    let questionList2 = []

    questionList1.push({
      question: "Your age?",
      fieldName: "age",
      choiceList: ["15-30", "30-40", "45+"],
      value: "",
    })

    questionList1.push({
      question: "Your gender?",
      fieldName: "gender",
      choiceList: ["Male", "Female", "Not to mention"],
      value: "",
    })

    questionList1.push({
      question: "Your profession?",
      fieldName: "profession",
      choiceList: ["Engineer", "Doctor", "Entreprenuer"],
      value: "",
    })


    questionList2.push({
      question: "Feel safe at night?",
      fieldName: "night_safety",
      choiceList: ["Always", "Sometimes", "Never"],
      value: "",
    })

    questionList2.push({
      question: "Travel frequently?",
      fieldName: "travel_frequency",
      choiceList: ["Yes", "No"],
      value: "",
    })

    return response.send({
      appVersion: appVersion,
      questionVersion: questionVersion,
      updateMust: updateMust,
      questionList: questionList1,
      status: true,
      responseMessage: ServerEnum.RESPONSE_SUCCESS
    })

  } catch (error) {
    util.printErrorOnResponse(error.name + ':' + error.message,
      ' getAppData Catch',
      ' controllers/DataController.js')
    return util.sendErrorResponse(response)
  }
}

async function submitUserQuestionnaire(request, response) {
  try {
    let { questionList, userId, firebasePushNotificationToken } = request.body;

    if (userId === null || userId === undefined || userId === "") {
      userId = util.createBigId('USER')
    }

    let data = {}
    data.id = userId
    data.firebasePushNotificationToken = firebasePushNotificationToken
    data.createdTime = util.currentTimestamp()
    data.accessPattern = AccessPattern.USER_INFO

    for (let question of questionList) {
      data[question.fieldName] = question.value
    }

    var params = {
      TableName: ServerConfigData.tableName,
      Item: data
    };
    await docClient.put(params).promise();

    return response.send({
      userId: userId,
      status: true,
      responseMessage: ServerEnum.RESPONSE_SUCCESS
    })

  } catch (error) {
    util.printErrorOnResponse(error.name + ':' + error.message,
      ' submitUserQuestionnaire Catch',
      ' controllers/DataController.js')
    return util.sendErrorResponse(response)
  }
}

async function submitUserLocationData(request, response) {
  try {
    let data = { ...request.body }
    data.createdTime = util.currentTimestamp()
    data.accessPattern = AccessPattern.LOCATION_INFO

    var params = {
      TableName: ServerConfigData.tableName,
      Item: data
    };
    await docClient.put(params).promise();

    return response.send({
      status: true,
      responseMessage: ServerEnum.RESPONSE_SUCCESS
    })

  } catch (error) {
    util.printErrorOnResponse(error.name + ':' + error.message,
      ' submitUserLocationData Catch',
      ' controllers/DataController.js')
    return util.sendErrorResponse(response)
  }
}

async function checkLocationSafety(request, response) {
  try {
    return response.send({
      status: true,
      responseMessage: 'This neighbourhood is a safe area',
    })

  } catch (error) {
    util.printErrorOnResponse(error.name + ':' + error.message,
      ' checkLocationSafety Catch',
      ' controllers/DataController.js')
    return util.sendErrorResponse(response)
  }
}

async function healthCheck(request, response) {
  return response.sendStatus(200)
}

async function apiCheck(request, response) {
  return response.send({
    version: 2,
    serverEnvironment: env,
    customEnvData: envCheckData,
    status: true,
    responseMessage: ServerEnum.RESPONSE_SUCCESS
  })
}

module.exports = {
  getAppData,
  submitUserQuestionnaire,
  submitUserLocationData,
  checkLocationSafety,
  healthCheck,
  apiCheck
};
