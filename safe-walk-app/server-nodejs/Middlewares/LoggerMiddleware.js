const util = require('../utils/util')

var LoggerMiddleWare = function (req, res, next) {
    console.log(util.currentTime() + " VISITING " + req.originalUrl);
    next()
}


module.exports = LoggerMiddleWare
  