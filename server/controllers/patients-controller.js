const catchAsync = require("../utils/catch-async");
const User = require("../models/user-schema");

exports.getPatients = catchAsync(async (req, res, next) => {
  const users = await User.find({ role: "patient" });

  res.status(200).json(users);
});
