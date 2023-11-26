const { transform, isEqual, isObject } = require('lodash')
const moment = require('moment')
const util = require('./util')
const sinon = require("sinon");

exports.dateAsString1 = function () {
    return moment().format("MMM Do YY"); // Jun 22nd 21
};

exports.dateAsString2 = function () {
    return moment().format("DD/MM/yy"); // 10/22/2021
};

exports.dateToDateString = function (date) {
    return moment(date).format("DD/MM/yy"); // 10/22/2021
};

exports.parseDate = function (dateString) {
    return moment(dateString, 'DD/MM/YYYY').toDate();
}

exports.isValidDate = function (data) {
    if (isNaN(data.getTime()))
        return false

    return true
}

exports.convertToUTCTimestamp = (unixTimestamp) => {
   return  moment.unix(unixTimestamp).format("YYYY-MM-DD HH:mm:ss");
}

exports.schedulerCheck = function () {
    const nextDay = "2021-06-13T18:00:00.000Z"
    const nextCheckDate = new Date(nextDay)
    const todayDate = new Date()
    var dif = nextCheckDate.getTime() - todayDate.getTime();
    var clock = sinon.useFakeTimers(new Date());
    clock.tick(dif);
    return clock
}

exports.convertToTimeStamp = function(date){
    var timestamp = date.getTime();
    return timestamp
}


