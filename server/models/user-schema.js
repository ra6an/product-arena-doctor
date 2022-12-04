const mongoose = require("mongoose");
const bcryptjs = require("bcryptjs");

const userSchema = mongoose.Schema({
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    enum: ["doctor", "patient"],
    default: "patient",
  },
  patientCase: {
    type: String,
  },
  at: {
    type: Number,
  },
});

userSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();

  this.password = await bcryptjs.hash(this.password, 12);
  next();
});

userSchema.methods.checkPassword = async function (
  enteredPassword,
  hashedPassword
) {
  return await bcryptjs.compare(enteredPassword, hashedPassword);
};

const User = mongoose.model("User", userSchema);

module.exports = User;
