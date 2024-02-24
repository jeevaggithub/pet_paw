class CommentModel {
  final String commentId;
  final String uid;
  final String postId;
  final String name;
  final String profilePic;
  final String commentText;
  final datePublished;

  const CommentModel({
    required this.commentId,
    required this.uid,
    required this.postId,
    required this.name,
    required this.profilePic,
    required this.commentText,
    required this.datePublished,
  });
  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'uid': uid,
        'postId': postId,
        'name': name,
        'profilePic': profilePic,
        'commmentText': commentText,
        'datePublished': datePublished,
      };
}
