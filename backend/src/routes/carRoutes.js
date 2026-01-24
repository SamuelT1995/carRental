const express = require("express");
const router = express.Router();
const carController = require("../controllers/carController");

router.get("/", carController.getAllCars);
router.post("/add", carController.addCar); // We'll use this to seed dummy data

module.exports = router;
