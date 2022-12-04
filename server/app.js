// PACKAGES
const express = require("express");

// OUR MODULES
const authRouter = require("./routes/auth-router");
const patientsRouter = require("./routes/patients-router");
const morgan = require("morgan");

const app = express();

if (process.env.NODE_ENV !== "production") {
  app.use(morgan("dev"));
}

app.use(express.json());
app.use(express.urlencoded({ extended: true, limit: "10kb" }));

// ROUTES
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/patients", patientsRouter);

module.exports = app;
