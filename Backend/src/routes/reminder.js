const express = require("express");
const router = express.Router();

const Reminder = require("../models/reminder");

router.post("/list/", async function (req, res) {
  var notes = await Reminder.find({ userid: req.body.userid });
  res.json(notes);
});

router.post("/add", async function (req, res) {
  await Reminder.deleteOne({ id: req.body.id });

  const newNote = Reminder({
    id: req.body.id,
    userid: req.body.userid,
    title: req.body.title,
    content: req.body.content,
    reminderDate: req.body.reminderDate,
  });
  await newNote.save();
  const response = {
    message: "Reminder created successfully! " + `id: ${req.body.id}`,
  };
  res.json(response);
});

router.post("/delete", async function (req, res) {
  await Reminder.deleteOne({ id: req.body.id });
  const response = {
    message: "Reminder deleted successfully! " + `id: ${req.body.id}`,
  };
  res.json(response);
});

module.exports = router;
