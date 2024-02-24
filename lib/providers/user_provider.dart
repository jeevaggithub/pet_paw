import 'package:flutter/material.dart';
import 'package:pet_paw/models/user_model.dart';
import 'package:pet_paw/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethod authMethod = AuthMethod();

  UserModel get getUser => _user!;

  // UserModel get getUser =>
  //     user ??
  //     const UserModel(
  //       email: 'user@example.com',
  //       uid: 'userUid',
  //       photoUrl: 'photoUrl',
  //       userName: 'username',
  //       bio: 'user bio',
  //       followers: [],
  //       following: [],
  //     ); // Provide a default UserModel if _user is null

  Future<void> refreshUser() async {
    print('snap data printing from refreshUser : hg uyfuyj');

    UserModel user = await authMethod.getUserDetails();
    // print('snap data printing from refreshUser : ${user.photoUrl}');
    // UserModel userRef = await _authMethod.getUserDetails();

    _user = user;
    print('snap data printing from refreshUser -userref : ${_user!.photoUrl}');

    notifyListeners();
  }
}
