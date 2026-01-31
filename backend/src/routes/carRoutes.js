const express = require("express");
const router = express.Router();
const carController = require("../controllers/carController");

router.get("/", carController.getCars);
router.get("/:id", carController.getCarById);

module.exports = router;
