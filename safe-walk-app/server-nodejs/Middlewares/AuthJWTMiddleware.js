const util = require('../utils/util')
const jwt = require("jsonwebtoken");


var AuthJWTMiddleware = function (req, res, next) {
    // Gather the jwt access token from the request header
    const token = req.headers['authorization']
    if (token == null) return util.sendJWTTokenErrorResponse(res)

    jwt.verify(token, process.env.TOKEN_SECRET, (err) => {
        if (err) {
            util.printErrorOnResponse(err, 'authenticateToken', 'middlewares/authjwtM.js')
            return util.sendJWTTokenErrorResponse(res)
        }
        next()
    })
}

module.exports = AuthJWTMiddleware