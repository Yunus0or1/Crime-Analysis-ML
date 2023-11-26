var dataController = require('../Controllers/DataController.js');
const LoggerMiddleware = require('../Middlewares/LoggerMiddleware.js')
const AuthJWTMiddleware = require('../Middlewares/AuthJWTMiddleware.js')

module.exports = function (app) {

	app.get('/',
		LoggerMiddleware,
		dataController.healthCheck);

	app.get('/health',
		LoggerMiddleware,
		dataController.healthCheck);

	app.get('/api',
		LoggerMiddleware,
		dataController.apiCheck);

	app.get('/get_app_data',
		LoggerMiddleware,
		dataController.getAppData);

	app.post('/submit_user_questionnaire',
		LoggerMiddleware,
		dataController.submitUserQuestionnaire);

	app.post('/submit_location_data',
		LoggerMiddleware,
		dataController.submitUserLocationData);

	app.post('/check_location_safety',
		LoggerMiddleware,
		dataController.checkLocationSafety);
}
