import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_paw/models/comment_model.dart';
import 'package:pet_paw/models/post_model.dart';
import 'package:pet_paw/models/user_model.dart';
import 'package:pet_paw/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String userName, String profImage) async {
    String res = "some error occured";
    String postId = const Uuid().v1();
    try {
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file, true);
      PostModel post = PostModel(
          description: description,
          uid: uid,
          userName: userName,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    print('res: $res');
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(CommentModel comment) async {
    try {
      if (comment.commentText.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(comment.postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'uid': comment.uid,
          'postId': comment.postId,
          'name': comment.name,
          'profilePic': comment.profilePic,
          'commentText': comment.commentText,
          'datePublished': DateTime.now(),
        });
      } else {
        print('textField is empty');
      }
    } catch (e) {
      print(
        'From postComment : ${e.toString()}',
      );
    }
  }

  Future<String> deletePost(String postId) async {
    String res = "some error occured";
    try {
      if (postId.isNotEmpty) {
        await _firestore.collection('posts').doc(postId).delete();
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<UserModel> getUserById(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return UserModel.fromSnap(snapshot);
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
