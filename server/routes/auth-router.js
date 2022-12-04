const express = require("express");
const authController = require("../controllers/auth-controller");

const router = express.Router();

// GET
router.route("/").get(authController.auth, authController.getUser);

// POST
router.route("/login").post(authController.login);
router.route("/signup").post(authController.signUp);
router.route("/tokenIsValid").post(authController.checkTokenValidity);

module.exports = router;
