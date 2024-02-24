import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  const UserModel({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    try {
      var snapshot = snap.data() as Map<String, dynamic>;
      print('snap data printing from fromSnap: $snapshot');

      return UserModel(
        userName: snapshot['userName'] ?? 'DefaultUsername',
        uid: snapshot['uid'] ?? 'DefaultUID',
        email: snapshot['email'] ?? 'DefaultEmail',
        photoUrl: snapshot['photoUrl'] ?? 'DefaultPhotoUrl',
        bio: snapshot['bio'] ?? 'DefaultBio',
        followers: snapshot['followers'] ?? [],
        following: snapshot['following'] ?? [],
      );
    } catch (error) {
      print('Error in fromSnap: $error');
      return const UserModel(
          email: 'email',
          uid: 'uid',
          photoUrl: 'photoUrl',
          userName: 'userName',
          bio: 'bio',
          followers: [],
          following: []); // or return null or some default UserModel
    }
  }

  // static UserModel fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   print('snap data printing from fromSnap : ${snapshot}');

  //   return UserModel(
  //     userName: snapshot['username'],
  //     uid: snapshot['uid'],
  //     email: snapshot['email'],
  //     photoUrl: snapshot['photoUrl'],
  //     bio: snapshot['bio'],
  //     followers: snapshot['followers'],
  //     following: snapshot['following'],
  //   );
  // }
}
