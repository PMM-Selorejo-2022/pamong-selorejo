import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void addUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void removeUser() {
    user = null;
    notifyListeners();
  }
}
