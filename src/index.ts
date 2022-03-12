import bodyParser from "body-parser";
import express from "express";

import PostRoutes from "./routes/PostRoutes";

export const app = express();
var cors = require("cors");
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use("/Post", PostRoutes);

app.listen(4000, () => {
  console.log(`Server running on port 4000`);
});
