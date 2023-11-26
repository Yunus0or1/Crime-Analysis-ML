exports.awaitSomeTime = async function (awaitTimeInMilli) {
    await new Promise(resolve => setTimeout(resolve, awaitTimeInMilli));
};

exports.differenceInObjects = function (object, base) {
    return transform(object, (result, value, key) => {
        if (!isEqual(value, base[key])) {
            result[key] = isObject(value) && isObject(base[key]) ? difference(value, base[key]) : value;
        }
    });
}

exports.removeDuplication = function (objectList) {
    const objectMap = {}

    const newList = objectList.filter((singleObject) => {
        if (objectMap[JSON.stringify(singleObject)] == true) return false

        objectMap[JSON.stringify(singleObject)] = true
        return true
    })

    return newList
}

exports.removeDuplicationOnKey = function (objectList, key) {
    const objectMap = {}

    const newList = objectList.filter((singleObject) => {
        if (objectMap[singleObject[key]] == true) return false

        objectMap[singleObject[key]] = true
        return true
    })

    return newList
}

exports.blobToObject = function (data) {
    return JSON.parse(new Buffer.from(data, 'binary').toString());
};

exports.jsonifyObject = function (data) {
    if (data == null) return null

    if (!Array.isArray(data)) {
        Object.keys(data).forEach(function (key) {
            if (Buffer.isBuffer(data[key]))
                data[key] = util.blobToObject(data[key])
        })
        return data
    }

    if (Array.isArray(data)) {
        for (const singleData of data)
            Object.keys(singleData).forEach(function (key) {
                if (Buffer.isBuffer(singleData[key]))
                    singleData[key] = util.blobToObject(singleData[key])
            })
        return data
    }
}

exports.hashPassword = async function (plainPassword) {
    const saltRounds = 10;
    const hash = await bcrypt.hash(plainPassword, saltRounds);
    return hash
}

exports.matchPassword = async function (plainPassword, hash) {
    return await bcrypt.compare(plainPassword, hash);;
}

exports.authCreds = function (user) {
    return {
        'userId': user.userId,
        'jwtToken': jwt.sign(JSON.stringify(user), process.env.TOKEN_SECRET),
        'createdTime': util.currentTimestamp()
    };
};

exports.createEncrpytedData = function ({ data, key }) {
    return jwt.sign(data, key);
};

exports.createBigId = function (prefix) {
    return prefix + '-' + uuidv4().toString()
};

exports.currentTimestamp = function () {
    return Date.now()
};

exports.timeStampAddFromANow = function (additionalDay) {
    var newDate = new Date();
    newDate.setDate(newDate.getDate() + additionalDay);
    return newDate.getTime();
};

exports.currentTime = function (prefix) {
    var now = new Date;
    return (now.getUTCHours() + ':' + now.getUTCMinutes() + ':' + now.getUTCSeconds())
};

exports.randomNumber = function () {
    return Math.floor(
        Math.random() * (99999 - 10000) + 10000
    )
};

exports.sendSuccessResponse = function (res) {
    return res.send({
        'status': true,
        'responseMessage': ServerEnum.RESPONSE_SUCCESS
    });
};

exports.sendErrorResponse = function (res) {
    return res.send({
        'status': false,
        'responseMessage': ServerEnum.RESPONSE_CONNECTION_ERROR
    });
};

exports.sendDatabaseErrorResponse = function (res) {
    return res.send({
        'status': false,
        'responseMessage': ServerEnum.RESPONSE_DATABASE_CONNECTION_ERROR
    });
};

exports.sendJWTTokenErrorResponse = function (res) {
    return res.send({
        'status': false,
        'responseMessage': ServerEnum.RESPONSE_INVALID_JWT_TOKEN
    });
};

exports.printErrorOnResponse = function (err, methodName, fileName) {
    console.log('Error in ' + methodName + ' in ' + fileName);
    console.log(err)
};

exports.logResponse = async function ({ message, methodName, fileName, primaryId }) {
    try {
        let logId = util.createBigId('LOG')

        const logDetails = `Log in ${methodName} in ${fileName}:  ${message}`

        new Promise(function (resolve, reject) {
            dbConnection.query(`INSERT INTO log_table
                (logId, logDetails, createdTime, primaryId) VALUES (?,?,?,?)`,
                [logId, JSON.stringify(logDetails),
                    util.currentTimestamp(), primaryId],
                function (error, result, field) {
                    if (error) {
                        util.printErrorOnResponse(error.name + ':' + error.message, 'logError', ' Util/Log')
                    };
                    resolve()
                })
        });
    } catch (err) {

    }
};

exports.removeSpace = function (str) {
    if (!str) return;
    return str.replace(/\s+/g, '')
};

exports.sendUserRoleAccessDeniedResponse = function (res) {
    return res.send({
        'status': false,
        'responseMessage': ServerEnum.RESPONSE_ACCESS_DENIED
    });
};

const { v4: uuidv4 } = require('uuid');
const jwt = require("jsonwebtoken");
const bcrypt = require('bcryptjs');
const { ServerEnum } = require('../configs/EnumData.js');
const util = require('./util');
const EnumData = require('../configs/EnumData.js');
const dbConnection = require("../configs/dbConfig.js");


