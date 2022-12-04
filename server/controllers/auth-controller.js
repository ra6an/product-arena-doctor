//
const catchAsync = require("../utils/catch-async");
const User = require("../models/user-schema");
const jwt = require("jsonwebtoken");

const TOKEN_SECRET = process.env.TOKEN_SECRET;

exports.getUser = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.user);

  res.status(200).json({
    ...user._doc,
    token: req.token,
  });
});

exports.login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new AppError("Please provide valid email and password!", 400));
  }

  const user = await User.findOne({ email }).select("+password");

  if (!user) {
    return res
      .status(400)
      .json({ msg: "User with this email does not exist!" });
  }

  const compare = await user.checkPassword(password, user.password);

  if (!compare) {
    return res.status(400).json({ msg: "Incorrect password." });
  }

  const token = jwt.sign({ id: user._id }, TOKEN_SECRET);
  const signedUser = await User.findOne({ email });

  res.status(200).json({ ...signedUser._doc, token });
});

exports.signUp = catchAsync(async (req, res, next) => {
  const { firstName, lastName, email, password, patientCase, at } = req.body;

  const existingUser = await User.findOne({ email });

  if (existingUser) {
    return res
      .status(400)
      .json({ msg: "User with same email already exists!" });
  }

  let newUser = new User({
    email,
    password,
    firstName,
    lastName,
    patientCase,
    at,
  });

  newUser = await newUser.save();

  res.status(200).json(newUser);
});

exports.auth = catchAsync(async (req, res, next) => {
  const token = req.header("x-auth-token");

  if (!token) {
    return res.status(401).json({ msg: "No auth token, access denied!" });
  }

  const verified = jwt.verify(token, TOKEN_SECRET);

  if (!verified) {
    return res
      .status(401)
      .json({ msg: "Token verification failed, authorization denied!" });
  }

  req.user = verified.id;
  req.token = token;

  next();
});

exports.checkTokenValidity = catchAsync(async (req, res, next) => {
  const token = req.header("x-auth-token");

  if (!token) {
    return res.json(false);
  }

  const verified = jwt.verify(token, TOKEN_SECRET);

  if (!verified) {
    return res.json(false);
  }

  const user = await User.findById(verified.id);

  if (!user) {
    return res.json(false);
  }

  res.json(true);
});
