import 'package:flutter/material.dart';
import 'package:pet_paw/models/user_model.dart';
import 'package:pet_paw/providers/user_provider.dart';
import 'package:pet_paw/screens/comment_screen.dart';
import 'package:pet_paw/utils/utils.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getCommentLen();
  }

  void getCommentLen() async {
    try {
      // Simulating fetching comment length from Firestore
      // Replace this with actual logic to fetch comment length
      commentLen = 10; // Example: Hardcoded comment length
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      commentLen = commentLen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.snap['userName'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9, // Example aspect ratio for the image
            child: Image.network(
              widget.snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    // Like functionality
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  icon: Icon(
                    widget.snap['likes'].contains(user.uid)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.snap['likes'].contains(user.uid)
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(snap: widget.snap),
                    ),
                  ),
                  icon: const Icon(Icons.comment, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'View all $commentLen comments',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
