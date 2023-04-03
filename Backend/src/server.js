const express = require("express");
const app = express();

const mongoose = require("mongoose");

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
const Note = require("./models/note");

mongoose
  .connect(
    "mongodb+srv://shreynagda:shrey0308@cluster0.zxdkj5v.mongodb.net/?retryWrites=true&w=majority"
  )
  .then(function () {
    app.get("/", function (req, res) {
      res.json({
        statusCode: res.statusCode,
        message: "API works!",
      });
    });

    const noteRouter = require("./routes/note");
    app.use("/notes", noteRouter);
  });

const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
  console.log("Server started at PORT: " + PORT);
});
