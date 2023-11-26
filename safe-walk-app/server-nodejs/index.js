const cors = require("cors");
const express = require("express");

const app = express();

app.use(express.json());
app.use(cors());

require("./Routes/DataBaseRoute.js")(app);
require("./Routes/DataRoute.js")(app);

// listen
let port = process.env.PORT || 8787
app.listen(port, () => console.log(`--------|| Server started on ${port} ||----------`));
