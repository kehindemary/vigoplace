import 'package:flutter/material.dart';
import 'package:vigoplace/core/models/user_model.dart';
import 'package:vigoplace/core/services/auth_services.dart';
class UserProvider with ChangeNotifier {

  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}