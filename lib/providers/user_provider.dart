import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethods _authMethods=AuthMethods();
Color? _col=Colors.amber;

  User get getUser => _user!;

  Future<void> refreshUser()async{
User  user=await _authMethods.getuserDetails();
_user=user;

notifyListeners();
  }
}