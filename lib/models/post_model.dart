import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const PostModel(
      {required this.description,
      required this.uid,
      required this.userName,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "userName": userName,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes,
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    try {
      var snapshot = snap.data() as Map<String, dynamic>;
      print('snap data printing from fromSnap: $snapshot');

      return PostModel(
        description: snapshot['description'] ?? 'Defaultdescription',
        uid: snapshot['uid'] ?? 'DefaultUID',
        userName: snapshot['userName'] ?? 'DefaultuserName',
        postId: snapshot['postId'] ?? 'DefaultpostId',
        datePublished: snapshot['datePublished'] ?? 'DefaultdatePublished',
        postUrl: snapshot['postUrl'] ?? 'default photo url',
        profImage: snapshot['profImage'] ?? 'default profile image',
        likes: snapshot['likes'] ?? '',
      );
    } catch (error) {
      print('Error in fromSnap: $error');
      return const PostModel(
          description: 'description',
          uid: 'uid',
          userName: 'userName',
          postId: 'postId',
          datePublished: 'datePublished',
          postUrl: 'default photo url',
          profImage: 'default profile image',
          likes: ''); // or return null or some default UserModel
    }
  }
}
