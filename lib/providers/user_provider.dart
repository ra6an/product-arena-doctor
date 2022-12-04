import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    password: '',
    role: '',
    token: '',
    firstName: '',
    lastName: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;

    notifyListeners();
  }
}
