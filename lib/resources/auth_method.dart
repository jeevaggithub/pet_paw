import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_paw/models/user_model.dart';
import 'package:pet_paw/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(currentUser.uid).get();
      print('snap data printing from getUserDetails: ${snap.data()}');
      return UserModel.fromSnap(snap);
    } catch (error) {
      print('Error in getUserDetails: $error');
      return const UserModel(
        userName: 'username',
        uid: 'uid',
        email: 'email',
        photoUrl: 'photoUrl',
        bio: 'bio',
        followers: [],
        following: [],
      ); // or return null or some default UserModel
    }
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String bio,
    required String userName,
    required Uint8List file,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          userName.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('created user : ${cred.user!.uid}');

        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profilePics', file, false);

        // Create user model
        UserModel user = UserModel(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          userName: userName,
          bio: bio,
          followers: [],
          following: [],
        );

        // Add user to the database using auto-generated document ID
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        // Navigate to mobile responsive screen upon successful sign-up
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const MobileScreenLayout(), // Redirect to your mobile responsive screen
        //   ),
        // );

        res = 'success';
      } else {
        res = 'All fields are required';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //signUp user
  // Future<String> signupUser({
  //   required String email,
  //   required String password,
  //   required String bio,
  //   required String userName,
  //   required Uint8List file,
  // }) async {
  //   String res = 'Some error occured';
  //   try {
  //     if (email.isNotEmpty ||
  //         password.isNotEmpty ||
  //         bio.isNotEmpty ||
  //         userName.isNotEmpty) {
  //       //register user
  //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       print(cred.user!.uid);

  //       String photoUrl = await StorageMethod()
  //           .uploadImageToStorage('profilePics', file, false);

  //       //add user to the database uisng set method

  //       UserModel user = UserModel(
  //           email: email,
  //           uid: cred.user!.uid,
  //           photoUrl: photoUrl,
  //           userName: userName,
  //           bio: bio,
  //           followers: [],
  //           following: []);

  //       await _firestore.collection('users').doc(cred.user!.uid).set(
  //             user.toJson(),
  //           );
  //       res = 'success';
  //     }
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }

  //logging user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter creds';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
