const express = require("express");
const patientsController = require("../controllers/patients-controller");
const authController = require("../controllers/auth-controller");

const router = express.Router();

// GET
router.route("/get-patients").get(patientsController.getPatients);

// POST
// router.route("/login").post(authController.login);
// router.route("/signup").post(authController.signUp);
// router.route("/tokenIsValid").post(authController.checkTokenValidity);

module.exports = router;
